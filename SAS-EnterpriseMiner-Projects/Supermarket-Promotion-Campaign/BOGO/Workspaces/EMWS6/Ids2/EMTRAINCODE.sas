*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS6 "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6";
*------------------------------------------------------------*;
* Ids2: Creating DATA data;
*------------------------------------------------------------*;
data EMWS6.Ids2_DATA (label="")
/ view=EMWS6.Ids2_DATA
;
set HW2.HW2_BA8880_SUPERMARKETDATASET;
run;
