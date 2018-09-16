length IMP_DemGender $1;
label IMP_DemGender = 'Imputed: Gender';
IMP_DemGender = DemGender;
if DemGender = '' then IMP_DemGender = 'U';
