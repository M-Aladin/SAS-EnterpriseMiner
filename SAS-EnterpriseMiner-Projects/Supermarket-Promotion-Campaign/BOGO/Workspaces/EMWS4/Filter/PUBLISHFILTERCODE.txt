if
( AffluenceGrade ne . and (0.99<=AffluenceGrade) and (AffluenceGrade<=30.1))
and ( REP_Age ne .)
and ( REP_LoyaltyTime ne .)
and ( TotalSpend eq . or (0.99<=TotalSpend) and (TotalSpend<=50000.01))
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
