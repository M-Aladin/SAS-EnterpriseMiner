

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(REP_AdvertisementZone,$CHAR10.);
length _FILTERNORM1  $32;
drop _FILTERNORM1 ;
%dmnormcp(_FILTERFMT1,_FILTERNORM1);
if
_FILTERNORM1 not in ( 'BORDER')
 and
_SEGMENT_LABEL_ not in ( 'Cluster2' , 'Cluster3' , 'Cluster4')
and
( AffluenceGrade eq . or (-1.512595995<=AffluenceGrade) and (AffluenceGrade<=18.910349926))
and ( CleanserProducts eq . or (-2.061834775<=CleanserProducts) and (CleanserProducts<=6.0147172304))
and ( DayCareProducts eq . or (-1.850662131<=DayCareProducts) and (DayCareProducts<=4.8329431392))
and ( LotionProducts eq . or (-2.478980335<=LotionProducts) and (LotionProducts<=6.9121223367))
and ( NightRepairProducts eq . or (-1.470434167<=NightRepairProducts) and (NightRepairProducts<=3.444978714))
and ( REP_Age eq . or (14.266582768<=REP_Age) and (REP_Age<=93.386224818))
and ( REP_LoyaltyTime eq . or (-7.314216626<=REP_LoyaltyTime) and (REP_LoyaltyTime<=20.397620669))
and ( TimeSinceLastPurchase eq . or (-7.425906143<=TimeSinceLastPurchase) and (TimeSinceLastPurchase<=14.575893664))
and ( TotalSpend eq . or (-13845.28954<=TotalSpend) and (TotalSpend<=22593.828395))
;
