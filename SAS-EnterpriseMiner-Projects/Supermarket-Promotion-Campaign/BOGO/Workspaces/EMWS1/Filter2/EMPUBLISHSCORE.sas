if
_SEGMENT_LABEL_ not in ( 'Cluster1' , 'Cluster3' , 'Cluster4')
and
( AffluenceGrade eq . or (2<=AffluenceGrade) and (AffluenceGrade<=23))
and ( CleanserProducts eq . or (0<=CleanserProducts) and (CleanserProducts<=4))
and ( DayCareProducts eq . or (0<=DayCareProducts) and (DayCareProducts<=3))
and ( LotionProducts eq . or (0<=LotionProducts) and (LotionProducts<=5))
and ( NightRepairProducts eq . or (0<=NightRepairProducts) and (NightRepairProducts<=2))
and ( REP_Age eq . or (22<=REP_Age) and (REP_Age<=79))
and ( REP_LoyaltyTime eq . or (1<=REP_LoyaltyTime) and (REP_LoyaltyTime<=31))
and ( TimeSinceLastPurchase eq . or (1<=TimeSinceLastPurchase) and (TimeSinceLastPurchase<=26))
and ( TotalSpend eq . or (35<=TotalSpend) and (TotalSpend<=19598))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
