*------------------------------------------------------------*;
* Clus3: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus3: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus3: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus3: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter_TRAIN
dmdbcat=WORK.Clus3_DMDB
maxlevel = 513
out=WORK.Clus3_DMDB
;
class %DMDBClass;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus3: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMVQINTERVAL;
*------------------------------------------------------------* ;
* Clus3: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    CampaignViewedEmail FacebookLike LoyaltyClass MobileApplications
   PreviousCampaign REP_AdvertisementZone REP_ClusterGroup REP_Gender REP_Region
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus3: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus3_DMDB dmdbcat=WORK.Clus3_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 4 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus3_OUTVAR;
INITIAL radius=0
initial=OUTLIER
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus3_OUTSTAT outmean=EMWS1.Clus3_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Clus3\DMVQSCORECODE.sas"
group=Clus3
;
run;
quit;
*------------------------------------------------------------* ;
* Clus3: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
   CampaignViewedEmail0 CampaignViewedEmail1 LoyaltyClassGold LoyaltyClassPlatinum
   MobileApplications0 MobileApplications1 PreviousCampaign0 PreviousCampaign1
   REP_AdvertisementZBorder REP_AdvertisementZCentral_Z1
   REP_AdvertisementZE_Central REP_AdvertisementZN_Central
   REP_AdvertisementZN_East REP_AdvertisementZN_West REP_AdvertisementZNE_Z1
   REP_AdvertisementZNE_Z2 REP_AdvertisementZNE_Z3 REP_AdvertisementZS_Central
   REP_AdvertisementZS_East REP_AdvertisementZS_West REP_AdvertisementZU
   REP_AdvertisementZW_Central REP_ClusterGroupA REP_ClusterGroupB
   REP_ClusterGroupC REP_ClusterGroupD REP_ClusterGroupE REP_ClusterGroupF
   REP_ClusterGroupU REP_GenderF REP_GenderM REP_RegionCentral REP_RegionNorth
   REP_RegionNorthEast REP_RegionSouth_East REP_RegionSouth_West REP_RegionU
%mend ;
