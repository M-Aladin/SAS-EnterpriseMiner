length IMP_DemReg $10;
label IMP_DemReg = 'Imputed: Geographic Region';
IMP_DemReg = DemReg;
if DemReg = '' then IMP_DemReg = 'U';
