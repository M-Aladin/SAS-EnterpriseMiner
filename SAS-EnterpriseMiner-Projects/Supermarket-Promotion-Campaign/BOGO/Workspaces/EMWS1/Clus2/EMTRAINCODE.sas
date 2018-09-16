*------------------------------------------------------------*;
* Clus2: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS1.Filter_TRAIN
dmdbcat=WORK.Clus2_DMDB
maxlevel = 513
out=WORK.Clus2_DMDB
;
class %DMDBClass;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMVQINTERVAL;
*------------------------------------------------------------* ;
* Clus2: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    CampaignViewedEmail FacebookLike LoyaltyClass MobileApplications
   PreviousCampaign REP_AdvertisementZone REP_ClusterGroup REP_Gender REP_Region
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus2: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus2_DMDB dmdbcat=WORK.Clus2_DMDB std=RANGE nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 3 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS1.Clus2_OUTVAR;
INITIAL radius=0
initial=OUTLIER
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS1.Clus2_OUTSTAT outmean=EMWS1.Clus2_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1\Clus2\DMVQSCORECODE.sas"
group=Clus2
;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: DMVQ Variables;
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
