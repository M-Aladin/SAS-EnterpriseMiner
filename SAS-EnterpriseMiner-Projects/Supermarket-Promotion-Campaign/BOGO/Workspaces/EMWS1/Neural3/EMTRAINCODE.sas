*------------------------------------------------------------*;
* Neural3: Create decision matrix;
*------------------------------------------------------------*;
data WORK.TargetBuy;
  length   TargetBuy                        $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           ;
  format   COUNT 10.
           ;
TargetBuy="1"; COUNT=5799; DATAPRIOR=0.2521304347826; TRAINPRIOR=0.2521304347826; DECPRIOR=.; DECISION1=1; DECISION2=0;
output;
TargetBuy="0"; COUNT=17201; DATAPRIOR=0.74786956521739; TRAINPRIOR=0.74786956521739; DECPRIOR=.; DECISION1=0; DECISION2=1;
output;
;
run;
proc datasets lib=work nolist;
modify TargetBuy(type=PROFIT label=TargetBuy);
label DECISION1= '1';
label DECISION2= '0';
run;
quit;
data EM_Neural3;
set EMWS1.Impt3_TRAIN(keep=
AffluenceGrade CampaignViewedEmail CleanserProducts DayCareProducts
FacebookLike LotionProducts LoyaltyClass MobileApplications NightRepairProducts
PreviousCampaign REP_AdvertisementZone REP_Age REP_ClusterGroup REP_Gender
REP_LoyaltyTime REP_Region TargetBuy TimeSinceLastPurchase TotalSpend );
run;
*------------------------------------------------------------* ;
* Neural3: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC) TargetBuy(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural3: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural3: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural3
dmdbcat=WORK.Neural3_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
TargetBuy
;
run;
quit;
*------------------------------------------------------------* ;
* Neural3: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural3: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;
    CampaignViewedEmail FacebookLike MobileApplications PreviousCampaign
%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural3: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    LoyaltyClass REP_AdvertisementZone REP_ClusterGroup REP_Gender REP_Region
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural3: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural3 dmdbcat=WORK.Neural3_DMDB
validdata = EMWS1.Impt3_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %BININPUTS / level=nominal id=bin
;
input %NOMINPUTS / level=nominal id=nom
;
target TargetBuy / level=NOMINAL id=TargetBuy
bias
;
arch MLP
Hidden=6
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural3_PRELIM_OUTEST
;
save network=EMWS1.Neural3_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS1.Neural3_outest estiter=1
Outfit=EMWS1.Neural3_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural3_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural3;
by _VMISC_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural3(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural3_INITIAL;
set EMWS1.Neural3_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural3 dmdbcat=WORK.Neural3_DMDB
validdata = EMWS1.Impt3_VALIDATE
network = EMWS1.Neural3_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural3_INITIAL;
train tech=NONE;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Neural3\SCORECODE.sas"
group=Neural3
;
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Neural3\RESIDUALSCORECODE.sas"
group=Neural3
residual
;
;
score data=EMWS1.Impt3_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural3_OUTKEY;
score data=EMWS1.Impt3_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS1.Neural3_OUTKEY;
run;
quit;
data EMWS1.Neural3_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural3_EMESTIMATE;
set EMWS1.Neural3_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural3;
run;
quit;
