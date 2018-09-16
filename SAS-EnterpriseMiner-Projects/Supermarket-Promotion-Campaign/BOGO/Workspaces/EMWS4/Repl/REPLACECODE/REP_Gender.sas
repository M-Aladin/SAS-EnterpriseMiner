   
* ;
* Defining: REP_Gender;
* ;
Length REP_Gender$1;
Label REP_Gender='Replacement: Gender';
format REP_Gender $CHAR1.;
REP_Gender=Gender;
* ;
* Variable: Gender;
* ;
_UFORMAT200 = strip(
put(Gender,$CHAR1.));
if _UFORMAT200 =  "" then
REP_Gender="U";
