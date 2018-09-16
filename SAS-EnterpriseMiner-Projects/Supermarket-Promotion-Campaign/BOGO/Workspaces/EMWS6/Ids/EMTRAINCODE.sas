*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS6 "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS6.Ids_DATA (label="")
/ view=EMWS6.Ids_DATA
;
set HW2.HW2_BA8880_SUPERMARKETDATASET;
run;
