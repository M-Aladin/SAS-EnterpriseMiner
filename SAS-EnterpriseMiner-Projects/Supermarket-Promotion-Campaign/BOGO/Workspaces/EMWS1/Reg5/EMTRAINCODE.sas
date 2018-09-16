*------------------------------------------------------------*;
* Reg5: Create decision matrix;
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
set EMWS1.Impt4_TRAIN(keep=
AffluenceGrade CampaignViewedEmail CleanserProducts DayCareProducts
FacebookLike LotionProducts LoyaltyClass MobileApplications NightRepairProducts
PreviousCampaign REP_AdvertisementZone REP_Age REP_ClusterGroup REP_Gender
REP_LoyaltyTime REP_Region TargetBuy TimeSinceLastPurchase TotalSpend );
run;
*------------------------------------------------------------* ;
* Reg5: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC) TargetBuy(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg5: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg5: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg5_DMDB
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
* Reg5: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg5_DMDB
validata = EMWS1.Impt4_VALIDATE
outest = EMWS1.Reg5_EMESTIMATE
outterms = EMWS1.Reg5_OUTTERMS
outmap= EMWS1.Reg5_MAPDS namelen=200
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
AffluenceGrade*AffluenceGrade
AffluenceGrade*CleanserProducts
AffluenceGrade*DayCareProducts
AffluenceGrade*LotionProducts
AffluenceGrade*NightRepairProducts
AffluenceGrade*REP_Age
AffluenceGrade*REP_LoyaltyTime
AffluenceGrade*TimeSinceLastPurchase
AffluenceGrade*TotalSpend
CleanserProducts*CleanserProducts
CleanserProducts*DayCareProducts
CleanserProducts*LotionProducts
CleanserProducts*NightRepairProducts
CleanserProducts*REP_Age
CleanserProducts*REP_LoyaltyTime
CleanserProducts*TimeSinceLastPurchase
CleanserProducts*TotalSpend
DayCareProducts*DayCareProducts
DayCareProducts*LotionProducts
DayCareProducts*NightRepairProducts
DayCareProducts*REP_Age
DayCareProducts*REP_LoyaltyTime
DayCareProducts*TimeSinceLastPurchase
DayCareProducts*TotalSpend
LotionProducts*LotionProducts
LotionProducts*NightRepairProducts
LotionProducts*REP_Age
LotionProducts*REP_LoyaltyTime
LotionProducts*TimeSinceLastPurchase
LotionProducts*TotalSpend
NightRepairProducts*NightRepairProducts
NightRepairProducts*REP_Age
NightRepairProducts*REP_LoyaltyTime
NightRepairProducts*TimeSinceLastPurchase
NightRepairProducts*TotalSpend
REP_Age*REP_Age
REP_Age*REP_LoyaltyTime
REP_Age*TimeSinceLastPurchase
REP_Age*TotalSpend
REP_LoyaltyTime*REP_LoyaltyTime
REP_LoyaltyTime*TimeSinceLastPurchase
REP_LoyaltyTime*TotalSpend
TimeSinceLastPurchase*TimeSinceLastPurchase
TimeSinceLastPurchase*TotalSpend
TotalSpend*TotalSpend
AffluenceGrade*AffluenceGrade*AffluenceGrade
AffluenceGrade*AffluenceGrade*CleanserProducts
AffluenceGrade*AffluenceGrade*DayCareProducts
AffluenceGrade*AffluenceGrade*LotionProducts
AffluenceGrade*AffluenceGrade*NightRepairProducts
AffluenceGrade*AffluenceGrade*REP_Age
AffluenceGrade*AffluenceGrade*REP_LoyaltyTime
AffluenceGrade*AffluenceGrade*TimeSinceLastPurchase
AffluenceGrade*AffluenceGrade*TotalSpend
AffluenceGrade*CleanserProducts*CleanserProducts
AffluenceGrade*CleanserProducts*DayCareProducts
AffluenceGrade*CleanserProducts*LotionProducts
AffluenceGrade*CleanserProducts*NightRepairProducts
AffluenceGrade*CleanserProducts*REP_Age
AffluenceGrade*CleanserProducts*REP_LoyaltyTime
AffluenceGrade*CleanserProducts*TimeSinceLastPurchase
AffluenceGrade*CleanserProducts*TotalSpend
AffluenceGrade*DayCareProducts*DayCareProducts
AffluenceGrade*DayCareProducts*LotionProducts
AffluenceGrade*DayCareProducts*NightRepairProducts
AffluenceGrade*DayCareProducts*REP_Age
AffluenceGrade*DayCareProducts*REP_LoyaltyTime
AffluenceGrade*DayCareProducts*TimeSinceLastPurchase
AffluenceGrade*DayCareProducts*TotalSpend
AffluenceGrade*LotionProducts*LotionProducts
AffluenceGrade*LotionProducts*NightRepairProducts
AffluenceGrade*LotionProducts*REP_Age
AffluenceGrade*LotionProducts*REP_LoyaltyTime
AffluenceGrade*LotionProducts*TimeSinceLastPurchase
AffluenceGrade*LotionProducts*TotalSpend
AffluenceGrade*NightRepairProducts*NightRepairProducts
AffluenceGrade*NightRepairProducts*REP_Age
AffluenceGrade*NightRepairProducts*REP_LoyaltyTime
AffluenceGrade*NightRepairProducts*TimeSinceLastPurchase
AffluenceGrade*NightRepairProducts*TotalSpend
AffluenceGrade*REP_Age*REP_Age
AffluenceGrade*REP_Age*REP_LoyaltyTime
AffluenceGrade*REP_Age*TimeSinceLastPurchase
AffluenceGrade*REP_Age*TotalSpend
AffluenceGrade*REP_LoyaltyTime*REP_LoyaltyTime
AffluenceGrade*REP_LoyaltyTime*TimeSinceLastPurchase
AffluenceGrade*REP_LoyaltyTime*TotalSpend
AffluenceGrade*TimeSinceLastPurchase*TimeSinceLastPurchase
AffluenceGrade*TimeSinceLastPurchase*TotalSpend
AffluenceGrade*TotalSpend*TotalSpend
CleanserProducts*CleanserProducts*CleanserProducts
CleanserProducts*CleanserProducts*DayCareProducts
CleanserProducts*CleanserProducts*LotionProducts
CleanserProducts*CleanserProducts*NightRepairProducts
CleanserProducts*CleanserProducts*REP_Age
CleanserProducts*CleanserProducts*REP_LoyaltyTime
CleanserProducts*CleanserProducts*TimeSinceLastPurchase
CleanserProducts*CleanserProducts*TotalSpend
CleanserProducts*DayCareProducts*DayCareProducts
CleanserProducts*DayCareProducts*LotionProducts
CleanserProducts*DayCareProducts*NightRepairProducts
CleanserProducts*DayCareProducts*REP_Age
CleanserProducts*DayCareProducts*REP_LoyaltyTime
CleanserProducts*DayCareProducts*TimeSinceLastPurchase
CleanserProducts*DayCareProducts*TotalSpend
CleanserProducts*LotionProducts*LotionProducts
CleanserProducts*LotionProducts*NightRepairProducts
CleanserProducts*LotionProducts*REP_Age
CleanserProducts*LotionProducts*REP_LoyaltyTime
CleanserProducts*LotionProducts*TimeSinceLastPurchase
CleanserProducts*LotionProducts*TotalSpend
CleanserProducts*NightRepairProducts*NightRepairProducts
CleanserProducts*NightRepairProducts*REP_Age
CleanserProducts*NightRepairProducts*REP_LoyaltyTime
CleanserProducts*NightRepairProducts*TimeSinceLastPurchase
CleanserProducts*NightRepairProducts*TotalSpend
CleanserProducts*REP_Age*REP_Age
CleanserProducts*REP_Age*REP_LoyaltyTime
CleanserProducts*REP_Age*TimeSinceLastPurchase
CleanserProducts*REP_Age*TotalSpend
CleanserProducts*REP_LoyaltyTime*REP_LoyaltyTime
CleanserProducts*REP_LoyaltyTime*TimeSinceLastPurchase
CleanserProducts*REP_LoyaltyTime*TotalSpend
CleanserProducts*TimeSinceLastPurchase*TimeSinceLastPurchase
CleanserProducts*TimeSinceLastPurchase*TotalSpend
CleanserProducts*TotalSpend*TotalSpend
DayCareProducts*DayCareProducts*DayCareProducts
DayCareProducts*DayCareProducts*LotionProducts
DayCareProducts*DayCareProducts*NightRepairProducts
DayCareProducts*DayCareProducts*REP_Age
DayCareProducts*DayCareProducts*REP_LoyaltyTime
DayCareProducts*DayCareProducts*TimeSinceLastPurchase
DayCareProducts*DayCareProducts*TotalSpend
DayCareProducts*LotionProducts*LotionProducts
DayCareProducts*LotionProducts*NightRepairProducts
DayCareProducts*LotionProducts*REP_Age
DayCareProducts*LotionProducts*REP_LoyaltyTime
DayCareProducts*LotionProducts*TimeSinceLastPurchase
DayCareProducts*LotionProducts*TotalSpend
DayCareProducts*NightRepairProducts*NightRepairProducts
DayCareProducts*NightRepairProducts*REP_Age
DayCareProducts*NightRepairProducts*REP_LoyaltyTime
DayCareProducts*NightRepairProducts*TimeSinceLastPurchase
DayCareProducts*NightRepairProducts*TotalSpend
DayCareProducts*REP_Age*REP_Age
DayCareProducts*REP_Age*REP_LoyaltyTime
DayCareProducts*REP_Age*TimeSinceLastPurchase
DayCareProducts*REP_Age*TotalSpend
DayCareProducts*REP_LoyaltyTime*REP_LoyaltyTime
DayCareProducts*REP_LoyaltyTime*TimeSinceLastPurchase
DayCareProducts*REP_LoyaltyTime*TotalSpend
DayCareProducts*TimeSinceLastPurchase*TimeSinceLastPurchase
DayCareProducts*TimeSinceLastPurchase*TotalSpend
DayCareProducts*TotalSpend*TotalSpend
LotionProducts*LotionProducts*LotionProducts
LotionProducts*LotionProducts*NightRepairProducts
LotionProducts*LotionProducts*REP_Age
LotionProducts*LotionProducts*REP_LoyaltyTime
LotionProducts*LotionProducts*TimeSinceLastPurchase
LotionProducts*LotionProducts*TotalSpend
LotionProducts*NightRepairProducts*NightRepairProducts
LotionProducts*NightRepairProducts*REP_Age
LotionProducts*NightRepairProducts*REP_LoyaltyTime
LotionProducts*NightRepairProducts*TimeSinceLastPurchase
LotionProducts*NightRepairProducts*TotalSpend
LotionProducts*REP_Age*REP_Age
LotionProducts*REP_Age*REP_LoyaltyTime
LotionProducts*REP_Age*TimeSinceLastPurchase
LotionProducts*REP_Age*TotalSpend
LotionProducts*REP_LoyaltyTime*REP_LoyaltyTime
LotionProducts*REP_LoyaltyTime*TimeSinceLastPurchase
LotionProducts*REP_LoyaltyTime*TotalSpend
LotionProducts*TimeSinceLastPurchase*TimeSinceLastPurchase
LotionProducts*TimeSinceLastPurchase*TotalSpend
LotionProducts*TotalSpend*TotalSpend
NightRepairProducts*NightRepairProducts*NightRepairProducts
NightRepairProducts*NightRepairProducts*REP_Age
NightRepairProducts*NightRepairProducts*REP_LoyaltyTime
NightRepairProducts*NightRepairProducts*TimeSinceLastPurchase
NightRepairProducts*NightRepairProducts*TotalSpend
NightRepairProducts*REP_Age*REP_Age
NightRepairProducts*REP_Age*REP_LoyaltyTime
NightRepairProducts*REP_Age*TimeSinceLastPurchase
NightRepairProducts*REP_Age*TotalSpend
NightRepairProducts*REP_LoyaltyTime*REP_LoyaltyTime
NightRepairProducts*REP_LoyaltyTime*TimeSinceLastPurchase
NightRepairProducts*REP_LoyaltyTime*TotalSpend
NightRepairProducts*TimeSinceLastPurchase*TimeSinceLastPurchase
NightRepairProducts*TimeSinceLastPurchase*TotalSpend
NightRepairProducts*TotalSpend*TotalSpend
REP_Age*REP_Age*REP_Age
REP_Age*REP_Age*REP_LoyaltyTime
REP_Age*REP_Age*TimeSinceLastPurchase
REP_Age*REP_Age*TotalSpend
REP_Age*REP_LoyaltyTime*REP_LoyaltyTime
REP_Age*REP_LoyaltyTime*TimeSinceLastPurchase
REP_Age*REP_LoyaltyTime*TotalSpend
REP_Age*TimeSinceLastPurchase*TimeSinceLastPurchase
REP_Age*TimeSinceLastPurchase*TotalSpend
REP_Age*TotalSpend*TotalSpend
REP_LoyaltyTime*REP_LoyaltyTime*REP_LoyaltyTime
REP_LoyaltyTime*REP_LoyaltyTime*TimeSinceLastPurchase
REP_LoyaltyTime*REP_LoyaltyTime*TotalSpend
REP_LoyaltyTime*TimeSinceLastPurchase*TimeSinceLastPurchase
REP_LoyaltyTime*TimeSinceLastPurchase*TotalSpend
REP_LoyaltyTime*TotalSpend*TotalSpend
TimeSinceLastPurchase*TimeSinceLastPurchase*TimeSinceLastPurchase
TimeSinceLastPurchase*TimeSinceLastPurchase*TotalSpend
TimeSinceLastPurchase*TotalSpend*TotalSpend
TotalSpend*TotalSpend*TotalSpend
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=VMISC
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
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Reg5\EMPUBLISHSCORE.sas"
group=Reg5
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Reg5\EMFLOWSCORE.sas"
group=Reg5
residual
;
run;
quit;
