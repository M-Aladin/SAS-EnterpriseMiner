label M_DemAge = "Imputation Indicator for DemAge";
if missing(DemAge) then M_DemAge = 1;
else M_DemAge= 0;
