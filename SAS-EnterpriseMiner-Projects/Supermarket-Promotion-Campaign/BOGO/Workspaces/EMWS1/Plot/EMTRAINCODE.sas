*------------------------------------------------------------* ;
* Plot: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    AffluenceGrade(ASC) CampaignViewedEmail(ASC) CleanserProducts(ASC)
   DayCareProducts(ASC) FacebookLike(ASC) LotionProducts(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) NightRepairProducts(ASC) PreviousCampaign(ASC)
   REP_AdvertisementZone(ASC) REP_Age(ASC) REP_ClusterGroup(ASC) REP_Gender(ASC)
   REP_LoyaltyTime(ASC) REP_Region(ASC) TargetBuy(DESC) TimeSinceLastPurchase(ASC)
   TotalSpend(ASC)
%mend DMDBClass;
*------------------------------------------------------------*;
* Plot: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Repl_TRAIN
dmdbcat=WORK.Plot_DMDB
maxlevel = 23
nonorm
;
class %DMDBClass;
target
TargetBuy
;
run;
quit;
*------------------------------------------------------------*;
* Plot: Creating variable by class target charts;
*------------------------------------------------------------*;
goptions ftext="SWISS";
goptions nodisplay device=PNG;
axis1 width=2 offset=(1,1) label=(rotate=90 angle=270) minor=none;
axis2 width=2 minor=none;
pattern1 value=solid;
proc gchart
data=EMWS1.Repl_TRAIN gout=WORK.PlotGRAPH;
*;
title "AffluenceGrade by TargetBuy";
vbar AffluenceGrade /
name = "AffluenceGrade x TargetBuy      " description = "AffluenceGrade by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "CampaignViewedEmail by TargetBuy";
vbar CampaignViewedEmail /
name = "CampaignViewedEx TargetBuy      " description = "CampaignViewedEmail by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "CleanserProducts by TargetBuy";
vbar CleanserProducts /
name = "CleanserProductx TargetBuy      " description = "CleanserProducts by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "DayCareProducts by TargetBuy";
vbar DayCareProducts /
name = "DayCareProductsx TargetBuy      " description = "DayCareProducts by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "FacebookLike by TargetBuy";
vbar FacebookLike /
name = "FacebookLike   x TargetBuy      " description = "FacebookLike by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "LotionProducts by TargetBuy";
vbar LotionProducts /
name = "LotionProducts x TargetBuy      " description = "LotionProducts by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "LoyaltyClass by TargetBuy";
vbar LoyaltyClass /
name = "LoyaltyClass   x TargetBuy      " description = "LoyaltyClass by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "MobileApplications by TargetBuy";
vbar MobileApplications /
name = "MobileApplicatix TargetBuy      " description = "MobileApplications by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "NightRepairProducts by TargetBuy";
vbar NightRepairProducts /
name = "NightRepairProdx TargetBuy      " description = "NightRepairProducts by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "PreviousCampaign by TargetBuy";
vbar PreviousCampaign /
name = "PreviousCampaigx TargetBuy      " description = "PreviousCampaign by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
discrete
raxis=axis1 maxis=axis2;
run;
title "REP_AdvertisementZone by TargetBuy";
vbar REP_AdvertisementZone /
name = "REP_Advertisemex TargetBuy      " description = "REP_AdvertisementZone by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "REP_Age by TargetBuy";
vbar REP_Age /
name = "REP_Age        x TargetBuy      " description = "REP_Age by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "REP_ClusterGroup by TargetBuy";
vbar REP_ClusterGroup /
name = "REP_ClusterGroux TargetBuy      " description = "REP_ClusterGroup by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "REP_Gender by TargetBuy";
vbar REP_Gender /
name = "REP_Gender     x TargetBuy      " description = "REP_Gender by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "REP_LoyaltyTime by TargetBuy";
vbar REP_LoyaltyTime /
name = "REP_LoyaltyTimex TargetBuy      " description = "REP_LoyaltyTime by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "REP_Region by TargetBuy";
vbar REP_Region /
name = "REP_Region     x TargetBuy      " description = "REP_Region by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "TimeSinceLastPurchase by TargetBuy";
vbar TimeSinceLastPurchase /
name = "TimeSinceLastPux TargetBuy      " description = "TimeSinceLastPurchase by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
title "TotalSpend by TargetBuy";
vbar TotalSpend /
name = "TotalSpend     x TargetBuy      " description = "TotalSpend by TargetBuy"
FREQ
type=FREQ
subgroup=TargetBuy
noframe
missing
raxis=axis1 maxis=axis2;
run;
quit;
title;
goptions display;
*------------------------------------------------------------*;
* Plot: Copying graphs to node folder;
*------------------------------------------------------------*;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\AffluenceGrade by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay AFFLUENC;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\CampaignViewedEmail by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay CAMPAIGN;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\CleanserProducts by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay CLEANSER;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\DayCareProducts by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay DAYCAREP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\FacebookLike by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay FACEBOOK;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\LotionProducts by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay LOTIONPR;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\LoyaltyClass by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay LOYALTYC;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\MobileApplications by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay MOBILEAP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\NightRepairProducts by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay NIGHTREP;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\PreviousCampaign by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay PREVIOUS;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_AdvertisementZone by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_ADVE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_Age by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_AGE;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_ClusterGroup by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_CLUS;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_Gender by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_GEND;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_LoyaltyTime by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_LOYA;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\REP_Region by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay REP_REGI;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\TimeSinceLastPurchase by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay TIMESINC;
quit;
goptions device=win;
filename gsasfile;
filename gsasfile "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Plot\GRAPH\TotalSpend by TargetBuy.png";
goptions device= PNG display gaccess= gsasfile gsfmode= replace cback= white;
proc greplay igout=WORK.PLOTGRAPH nofs;
replay TOTALSPE;
quit;
goptions device=win;
filename gsasfile;
