*------------------------------------------------------------*;
* Reg4: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Impt3_TRAIN(keep=
AffluenceGrade CampaignViewedEmail CleanserProducts DayCareProducts
FacebookLike LotionProducts LoyaltyClass MobileApplications NightRepairProducts
PreviousCampaign REP_AdvertisementZone REP_Age REP_ClusterGroup REP_Gender
REP_LoyaltyTime REP_Region TargetBuy TimeSinceLastPurchase TotalSpend );
run;
*------------------------------------------------------------* ;
* Reg4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC) TargetBuy(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg4_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
TargetBuy
;
run;
quit;
*------------------------------------------------------------*;
* Reg4: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg4_DMDB
validata = EMWS1.Impt3_VALIDATE
outest = EMWS1.Reg4_EMESTIMATE
outterms = EMWS1.Reg4_OUTTERMS
outmap= EMWS1.Reg4_MAPDS namelen=200
;
class
TargetBuy
CampaignViewedEmail
FacebookLike
LoyaltyClass
MobileApplications
PreviousCampaign
REP_AdvertisementZone
REP_ClusterGroup
REP_Gender
REP_Region
;
model TargetBuy =
AffluenceGrade
CampaignViewedEmail
CleanserProducts
DayCareProducts
FacebookLike
LotionProducts
LoyaltyClass
MobileApplications
NightRepairProducts
PreviousCampaign
REP_AdvertisementZone
REP_Age
REP_ClusterGroup
REP_Gender
REP_LoyaltyTime
REP_Region
TimeSinceLastPurchase
TotalSpend
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=NONE
Hierarchy=CLASS
Rule=NONE
SlEntry=0.02
SlStay=0.05
Start=0
Stop=0
include=0
MaxStep=20
;
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Reg4\EMPUBLISHSCORE.sas"
group=Reg4
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Reg4\EMFLOWSCORE.sas"
group=Reg4
residual
;
run;
quit;
