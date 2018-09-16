   
* ;
* Defining: REP_AdvertisementZone;
* ;
Length REP_AdvertisementZone$10;
Label REP_AdvertisementZone='Replacement: AdvertisementZone';
format REP_AdvertisementZone $CHAR10.;
REP_AdvertisementZone=AdvertisementZone;
* ;
* Variable: AdvertisementZone;
* ;
_UFORMAT200 = strip(
put(AdvertisementZone,$CHAR10.));
if _UFORMAT200 =  "" then
REP_AdvertisementZone="U";
