

length _FILTERFMT1  $200;
drop _FILTERFMT1 ;
_FILTERFMT1= put(FacebookLike,BEST12.0);


length _FILTERFMT2  $200;
drop _FILTERFMT2 ;
_FILTERFMT2= put(LoyaltyClass,$CHAR8.);


length _FILTERFMT3  $200;
drop _FILTERFMT3 ;
_FILTERFMT3= put(REP_Gender,$CHAR1.);
if
_FILTERFMT1 not in ( '           0')
 and
_FILTERFMT2 not in ( 'Diamond' , 'Silver')
 and
_FILTERFMT3 not in ( 'U')
and
( AffluenceGrade ne . and (0.99<=AffluenceGrade) and (AffluenceGrade<=30.1))
and ( REP_Age ne .)
and ( REP_LoyaltyTime ne .)
and ( TotalSpend eq . or (TotalSpend<=50000.01))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
