* ;
* Variable: Age ;
* ;
Label REP_Age='Replacement: Age';
Length REP_Age 8;
REP_Age =Age ;
if Age  eq . then REP_Age = . ;
else
if Age <1  then REP_Age  = . ;
* ;
* Variable: LoyaltyTime ;
* ;
Label REP_LoyaltyTime='Replacement: LoyaltyTime';
Length REP_LoyaltyTime 8;
REP_LoyaltyTime =LoyaltyTime ;
if LoyaltyTime  eq . then REP_LoyaltyTime = . ;
else
if LoyaltyTime >50  then REP_LoyaltyTime  = . ;
   
* ;
* Defining New Variables;
* ;
Length REP_AdvertisementZone $10;
Label REP_AdvertisementZone='Replacement: AdvertisementZone';
format REP_AdvertisementZone $CHAR10.;
REP_AdvertisementZone= AdvertisementZone;
Length REP_ClusterGroup $1;
Label REP_ClusterGroup='Replacement: ClusterGroup';
format REP_ClusterGroup $CHAR1.;
REP_ClusterGroup= ClusterGroup;
Length REP_Gender $1;
Label REP_Gender='Replacement: Gender';
format REP_Gender $CHAR1.;
REP_Gender= Gender;
Length REP_Region $10;
Label REP_Region='Replacement: Region';
format REP_Region $CHAR10.;
REP_Region= Region;
   
* ;
* Replace Specific Class Levels ;
* ;
length _UFormat200 $200;
drop   _UFORMAT200;
_UFORMAT200 = " ";
* ;
* Variable: AdvertisementZone;
* ;
_UFORMAT200 = strip(
put(AdvertisementZone,$CHAR10.));
if _UFORMAT200 =  "" then
REP_AdvertisementZone="U";
* ;
* Variable: ClusterGroup;
* ;
_UFORMAT200 = strip(
put(ClusterGroup,$CHAR1.));
if _UFORMAT200 =  "" then
REP_ClusterGroup="U";
* ;
* Variable: Gender;
* ;
_UFORMAT200 = strip(
put(Gender,$CHAR1.));
if _UFORMAT200 =  "" then
REP_Gender="U";
* ;
* Variable: Region;
* ;
_UFORMAT200 = strip(
put(Region,$CHAR10.));
if _UFORMAT200 =  "" then
REP_Region="U";
