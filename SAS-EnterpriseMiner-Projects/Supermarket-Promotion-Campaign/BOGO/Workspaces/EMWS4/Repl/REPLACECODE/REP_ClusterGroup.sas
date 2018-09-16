   
* ;
* Defining: REP_ClusterGroup;
* ;
Length REP_ClusterGroup$1;
Label REP_ClusterGroup='Replacement: ClusterGroup';
format REP_ClusterGroup $CHAR1.;
REP_ClusterGroup=ClusterGroup;
* ;
* Variable: ClusterGroup;
* ;
_UFORMAT200 = strip(
put(ClusterGroup,$CHAR1.));
if _UFORMAT200 =  "" then
REP_ClusterGroup="U";
