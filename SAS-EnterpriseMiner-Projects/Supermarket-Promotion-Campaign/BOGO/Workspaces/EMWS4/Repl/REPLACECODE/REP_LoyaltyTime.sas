* ;
*Variable: LoyaltyTime;
* ;
Label REP_LoyaltyTime= 'Replacement: LoyaltyTime';
length REP_LoyaltyTime 8;
REP_LoyaltyTime= LoyaltyTime;
if LoyaltyTime eq . then REP_LoyaltyTime = .;
else
if LoyaltyTime>50 then REP_LoyaltyTime=.;
