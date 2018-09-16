if NAME = "DemAffl" then delete;
else 
if NAME    = "IMP_DemAffl"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemAffl " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "DemAge" then delete;
else 
if NAME    = "IMP_DemAge"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemAge " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "DemClusterGroup" then delete;
else 
if NAME    = "IMP_DemClusterGroup"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemClusterGroup " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "DemGender" then delete;
else 
if NAME    = "IMP_DemGender"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemGender " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "DemReg" then delete;
else 
if NAME    = "IMP_DemReg"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemReg " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
if NAME = "DemTVReg" then delete;
else 
if NAME    = "IMP_DemTVReg"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "NOMINAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_DemTVReg " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
else 
if NAME  = "M_PromClass " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
else 
if NAME  = "M_PromSpend " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
if NAME = "PromTime" then delete;
else 
if NAME    = "IMP_PromTime"  then do;
   ROLE    = "INPUT" ;
   FAMILY  = "" ;
   REPORT  = "N" ;
   LEVEL   = "INTERVAL" ;
   ORDER   = "" ;
end;
else 
if NAME  = "M_PromTime " then do;
   ROLE  ="INPUT";
   LEVEL ="BINARY";
 end;
else 
if NAME  = "M_TargetBuy " then do;
   ROLE  ="INPUT";
   LEVEL ="UNARY";
 end;
