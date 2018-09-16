length IMP_DemTVReg $12;
label IMP_DemTVReg = 'Imputed: Television Region';
IMP_DemTVReg = DemTVReg;
if DemTVReg = '' then IMP_DemTVReg = 'London';
