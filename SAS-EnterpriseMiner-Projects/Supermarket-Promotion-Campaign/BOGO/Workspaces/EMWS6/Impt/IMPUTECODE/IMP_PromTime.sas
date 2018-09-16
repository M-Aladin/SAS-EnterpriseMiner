label IMP_PromTime = 'Imputed: Loyalty Card Tenure';
length IMP_PromTime 8;
IMP_PromTime = PromTime;
if missing(PromTime) then IMP_PromTime = 6.5710641399;
