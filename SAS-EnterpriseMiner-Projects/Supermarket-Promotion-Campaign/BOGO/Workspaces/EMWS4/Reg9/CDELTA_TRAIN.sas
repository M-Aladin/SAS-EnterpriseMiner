if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'AFFLUENCEGRADE'
'CLEANSERPRODUCTS'
'DAYCAREPRODUCTS'
'LOTIONPRODUCTS'
'MOBILEAPPLICATIONS'
'NIGHTREPAIRPRODUCTS'
'REP_AGE'
'REP_GENDER'
'REP_LOYALTYTIME'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg9: Rejected using stepwise selection";
end;
end;
