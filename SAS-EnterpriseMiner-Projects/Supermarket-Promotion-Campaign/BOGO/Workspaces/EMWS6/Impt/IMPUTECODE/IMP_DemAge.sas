label IMP_DemAge = 'Imputed: Age';
length IMP_DemAge 8;
IMP_DemAge = DemAge;
if missing(DemAge) then IMP_DemAge = 53.892095358;
