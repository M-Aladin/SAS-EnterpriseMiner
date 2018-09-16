   
* ;
* Defining: REP_Region;
* ;
Length REP_Region$10;
Label REP_Region='Replacement: Region';
format REP_Region $CHAR10.;
REP_Region=Region;
* ;
* Variable: Region;
* ;
_UFORMAT200 = strip(
put(Region,$CHAR10.));
if _UFORMAT200 =  "" then
REP_Region="U";
