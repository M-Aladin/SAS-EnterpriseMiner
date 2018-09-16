*------------------------------------------------------------*;
* Clus: Preliminary Clustering;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) LoyaltyClass(ASC)
   MobileApplications(ASC) PreviousCampaign(ASC) REP_AdvertisementZone(ASC)
   REP_ClusterGroup(ASC) REP_Gender(ASC) REP_Region(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS4.Filter_TRAIN
dmdbcat=WORK.Clus_DMDB
maxlevel = 513
out=WORK.Clus_DMDB
;
class %DMDBClass;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
%mend DMVQINTERVAL;
*------------------------------------------------------------* ;
* Clus: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    CampaignViewedEmail FacebookLike LoyaltyClass MobileApplications
   PreviousCampaign REP_AdvertisementZone REP_ClusterGroup REP_Gender REP_Region
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus_DMDB dmdbcat=WORK.Clus_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 50 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS4.Clus_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=WORK.Clus_OUTSTAT outmean=EMWS4.Clus_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS4\Clus\DMVQSCORECODE.sas"
group=Clus
;
run;
quit;
*------------------------------------------------------------* ;
* Clus: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    AffluenceGrade CleanserProducts DayCareProducts LotionProducts
   NightRepairProducts REP_Age REP_LoyaltyTime TimeSinceLastPurchase TotalSpend
   CampaignViewedEmail0 CampaignViewedEmail1 FacebookLike0 FacebookLike1
   LoyaltyClassDiamond LoyaltyClassGold LoyaltyClassPlatinum LoyaltyClassSilver
   MobileApplications0 MobileApplications1 PreviousCampaign0 PreviousCampaign1
   REP_AdvertisementZBorder REP_AdvertisementZCentral_Z1
   REP_AdvertisementZE_Central REP_AdvertisementZN_Central
   REP_AdvertisementZN_East REP_AdvertisementZN_West REP_AdvertisementZNE_Z1
   REP_AdvertisementZNE_Z2 REP_AdvertisementZNE_Z3 REP_AdvertisementZS_Central
   REP_AdvertisementZS_East REP_AdvertisementZS_West REP_AdvertisementZU
   REP_AdvertisementZW_Central REP_ClusterGroupA REP_ClusterGroupB
   REP_ClusterGroupC REP_ClusterGroupD REP_ClusterGroupE REP_ClusterGroupF
   REP_ClusterGroupU REP_GenderF REP_GenderM REP_GenderU REP_RegionCentral
   REP_RegionNorth REP_RegionNorthEast REP_RegionSouth_East REP_RegionSouth_West
   REP_RegionU
%mend ;
*------------------------------------------------------------*;
* Clus: Determining the number of clusters;
*------------------------------------------------------------*;
proc cluster data=EMWS4.Clus_OUTMEAN method=WARD pseudo outtree=EMWS4.Clus_CLUSSEED
;
var %dmvqvars;
copy _SEGMENT_;
run;
quit;
proc sort data =EMWS4.Clus_CLUSSEED out=WORK._SEED_;
by _ncl_;
where (_ccc_ > -99999.0);
run;
data WORK._SEED2_;
retain oJump occc oncl;
set WORK._SEED_;
_lccc_=lag(_ccc_);
if _lccc_ > . then jump = _ccc_ - _lccc_;
if jump<0 and ojump>0 then do;
* Have a local Max;
numclus = oncl;
cccvalue = occc;
output;
end;
ojump = jump;
occc = _ccc_;
oncl = _ncl_;
run;
proc print data=WORK._SEED2_ label;
var numclus cccvalue;
label numclus="%sysfunc(sasmsg(sashelp.dmine, rpt_numclus_vlabel ,  NOQUOTE))";
label cccvalue="%sysfunc(sasmsg(sashelp.dmine, rpt_ccc_vlabel ,     NOQUOTE))";
title10 "%sysfunc(sasmsg(sashelp.dmine, rpt_OptClus_title, NOQUOTE))";
run;
title10;
data WORK._SEED2_;
length msg $200;
set WORK._SEED2_ end=eof;
retain select cccSelect 0 numSel;
if _N_=1 then numSel = numClus;
if cccvalue>=3 then do;
if 20>= numclus >= 2 and cccSelect<1 then do;
cccSelect = 1;
select =1;
numSel = numClus;
end;
end;
else if 20>= numclus >= 2 and select<1 then do;
select = 1;
numSel = numClus;
end;
if eof then do;
if ^(select=1 and cccselect=1) then do;
put "*------------------------------------------------------------*";
put '*;';
put "WARNING: The number of clusters selected based on the CCC values may not be valid.  Please refer to the documentation on the Cubic Clustering Criterion.";
put '*;';
put "*------------------------------------------------------------*";
end;
if select<1 then do;
msg = sasmsg('sashelp.dmine', 'rpt_noCCCclusternum_note', 'NOQUOTE');
put msg;
end;
if cccselect<1 then do;
msg = sasmsg('sashelp.dmine', 'rpt_noValidclusterNum_note', 'NOQUOTE');
put msg;
end;
call symput('em_maxC', strip(put(numSel,best.)));
end;
run;
*------------------------------------------------------------*;
* Clus: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Clus: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus_DMDB dmdbcat=WORK.Clus_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 2 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS4.Clus_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS4.Clus_OUTSTAT outmean=EMWS4.Clus_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS4\Clus\DMVQSCORECODE.sas"
group=Clus
;
run;
quit;
