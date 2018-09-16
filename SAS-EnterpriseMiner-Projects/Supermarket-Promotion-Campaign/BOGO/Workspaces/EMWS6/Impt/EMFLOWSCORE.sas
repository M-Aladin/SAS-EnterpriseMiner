*;
*MOST FREQUENT VALUE (COUNT);
*;
length IMP_DemClusterGroup $1;
label IMP_DemClusterGroup = 'Imputed: Neighborhood Cluster-7 Level';
IMP_DemClusterGroup = DemClusterGroup;
if DemClusterGroup = '' then IMP_DemClusterGroup = 'C';
length IMP_DemGender $1;
label IMP_DemGender = 'Imputed: Gender';
IMP_DemGender = DemGender;
if DemGender = '' then IMP_DemGender = 'F';
length IMP_DemReg $10;
label IMP_DemReg = 'Imputed: Geographic Region';
IMP_DemReg = DemReg;
if DemReg = '' then IMP_DemReg = 'South East';
length IMP_DemTVReg $12;
label IMP_DemTVReg = 'Imputed: Television Region';
IMP_DemTVReg = DemTVReg;
if DemTVReg = '' then IMP_DemTVReg = 'London';
*;
*MEAN-MAX-MIN-MEDIAN-MIDRANGE AND ROBUST ESTIMATES;
*;
label IMP_DemAffl = 'Imputed: Affluence Grade';
length IMP_DemAffl 8;
IMP_DemAffl = DemAffl;
if missing(DemAffl) then IMP_DemAffl = 8.7030320204;
label IMP_DemAge = 'Imputed: Age';
length IMP_DemAge 8;
IMP_DemAge = DemAge;
if missing(DemAge) then IMP_DemAge = 53.892095358;
label IMP_PromTime = 'Imputed: Loyalty Card Tenure';
length IMP_PromTime 8;
IMP_PromTime = PromTime;
if missing(PromTime) then IMP_PromTime = 6.5710641399;
*;
*INDICATOR VARIABLES;
*;
label M_DemAffl = "Imputation Indicator for DemAffl";
if missing(DemAffl) then M_DemAffl = 1;
else M_DemAffl= 0;
label M_DemAge = "Imputation Indicator for DemAge";
if missing(DemAge) then M_DemAge = 1;
else M_DemAge= 0;
label M_DemClusterGroup = "Imputation Indicator for DemClusterGroup";
if DemClusterGroup = '' then M_DemClusterGroup = 1;
else M_DemClusterGroup= 0;
label M_DemGender = "Imputation Indicator for DemGender";
if DemGender = '' then M_DemGender = 1;
else M_DemGender= 0;
label M_DemReg = "Imputation Indicator for DemReg";
if DemReg = '' then M_DemReg = 1;
else M_DemReg= 0;
label M_DemTVReg = "Imputation Indicator for DemTVReg";
if DemTVReg = '' then M_DemTVReg = 1;
else M_DemTVReg= 0;
label M_PromTime = "Imputation Indicator for PromTime";
if missing(PromTime) then M_PromTime = 1;
else M_PromTime= 0;
