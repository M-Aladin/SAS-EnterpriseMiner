*------------------------------------------------------------*;
* Clus4: Training;
*------------------------------------------------------------*;
*------------------------------------------------------------* ;
* Clus4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    LoyaltyClass(ASC) REP_Gender(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Clus4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    AffluenceGrade DayCareProducts NightRepairProducts TimeSinceLastPurchase
%mend DMDBVar;
*------------------------------------------------------------*;
* Clus4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=EMWS4.Filter_TRAIN
dmdbcat=WORK.Clus4_DMDB
maxlevel = 513
out=WORK.Clus4_DMDB
;
class %DMDBClass;
var %DMDBVar;
run;
quit;
*------------------------------------------------------------* ;
* Clus4: Interval Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQINTERVAL;
    AffluenceGrade DayCareProducts NightRepairProducts TimeSinceLastPurchase
%mend DMVQINTERVAL;
*------------------------------------------------------------* ;
* Clus4: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro DMVQNOMINAL;
    LoyaltyClass REP_Gender
%mend DMVQNOMINAL;
*------------------------------------------------------------*;
* Clus4: Run DMVQ procedure;
*------------------------------------------------------------*;
title;
options nodate;
proc dmvq data=WORK.Clus4_DMDB dmdbcat=WORK.Clus4_DMDB std=STD nominal=GLM ordinal=RANK
;
input %DMVQINTERVAL / level=interval;
input %DMVQNOMINAL / level=nominal;
VQ maxc = 4 clusname=_SEGMENT_ CLUSLABEL="Segment Id" DISTLABEL="Distance";
MAKE outvar=EMWS4.Clus4_OUTVAR;
INITIAL radius=0
;
TRAIN tech=FORGY
;
SAVE outstat=EMWS4.Clus4_OUTSTAT outmean=EMWS4.Clus4_OUTMEAN;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS4\Clus4\DMVQSCORECODE.sas"
group=Clus4
;
run;
quit;
*------------------------------------------------------------* ;
* Clus4: DMVQ Variables;
*------------------------------------------------------------* ;
%macro dmvqvars;
    AffluenceGrade DayCareProducts NightRepairProducts TimeSinceLastPurchase
   LoyaltyClassDiamond LoyaltyClassGold LoyaltyClassPlatinum LoyaltyClassSilver
   REP_GenderF REP_GenderM REP_GenderU
%mend ;
