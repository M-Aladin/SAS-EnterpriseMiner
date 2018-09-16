*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS5 "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS5";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS5.Ids_DATA (label="")
/ view=EMWS5.Ids_DATA
;
set HW2.HW2_BA8880_SUPERMARKETDATASET;
run;
