*------------------------------------------------------------*;
* Data Source Setup;
*------------------------------------------------------------*;
libname EMWS1 "D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS1";
*------------------------------------------------------------*;
* Ids2: Creating DATA data;
*------------------------------------------------------------*;
data EMWS1.Ids2_DATA (label="")
/ view=EMWS1.Ids2_DATA
;
set SUPERMKT.SUPERMARKETCAMPAIGN;
run;
