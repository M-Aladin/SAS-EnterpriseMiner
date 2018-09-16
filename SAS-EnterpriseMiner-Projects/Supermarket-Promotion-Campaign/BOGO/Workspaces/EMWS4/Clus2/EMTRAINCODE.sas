*------------------------------------------------------------*;
* Clus2: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    CampaignViewedEmail(ASC) FacebookLike(ASC) MobileApplications(ASC)
   PreviousCampaign(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;

%mend DMDBVar;
*------------------------------------------------------------*;
* Clus2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS4.Filter_TRAIN
dmdbcat=WORK.Clus2_DMDB
maxlevel = 513
out=WORK.Clus2_DMDB
;
class %DMDBClass;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    CampaignViewedEmail FacebookLike MobileApplications PreviousCampaign
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus2: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus2_DMDB dmdbcat=WORK.Clus2_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 4 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS4.Clus2_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS4.Clus2_OUTSTAT outmean=EMWS4.Clus2_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS4\Clus2\DMVQSCORECODE.sas"
group=Clus2
;
run;
quit;
*------------------------------------------------------------* ;
* Clus2: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    CampaignViewedEmail0 CampaignViewedEmail1 FacebookLike0 FacebookLike1
   MobileApplications0 MobileApplications1 PreviousCampaign0 PreviousCampaign1
%mend ;
