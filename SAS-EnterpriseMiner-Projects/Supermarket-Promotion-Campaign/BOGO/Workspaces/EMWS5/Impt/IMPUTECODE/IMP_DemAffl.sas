label IMP_DemAffl = 'Imputed: Affluence Grade';
length IMP_DemAffl 8;
IMP_DemAffl = DemAffl;
if missing(DemAffl) then IMP_DemAffl = 8.7030320204;
