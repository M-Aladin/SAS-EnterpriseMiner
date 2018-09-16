*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS4 "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS4";
*------------------------------------------------------------*;
* Ids: Creating DATA data;
*------------------------------------------------------------*;
data EMWS4.Ids_DATA (label="")
/ view=EMWS4.Ids_DATA
;
set SUPERMKT.SUPERMARKETCAMPAIGN;
run;
