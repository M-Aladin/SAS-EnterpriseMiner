length IMP_DemClusterGroup $1;
label IMP_DemClusterGroup = 'Imputed: Neighborhood Cluster-7 Level';
IMP_DemClusterGroup = DemClusterGroup;
if DemClusterGroup = '' then IMP_DemClusterGroup = 'U';
