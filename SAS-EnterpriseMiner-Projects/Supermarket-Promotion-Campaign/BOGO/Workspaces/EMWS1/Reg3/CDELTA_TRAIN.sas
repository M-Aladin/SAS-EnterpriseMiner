if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'AFFLUENCEGRADE'
'CLEANSERPRODUCTS'
'DAYCAREPRODUCTS'
'MOBILEAPPLICATIONS'
'NIGHTREPAIRPRODUCTS'
'PREVIOUSCAMPAIGN'
'REP_AGE'
'REP_GENDER'
'TOTALSPEND'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg3: Rejected using stepwise selection";
end;
end;