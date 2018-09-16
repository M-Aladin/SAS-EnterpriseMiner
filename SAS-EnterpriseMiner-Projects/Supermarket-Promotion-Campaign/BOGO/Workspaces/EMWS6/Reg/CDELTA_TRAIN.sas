if ROLE in('INPUT', 'REJECTED') then do;
if upcase(NAME) in(
'IMP_DEMAFFL'
'IMP_DEMAGE'
'IMP_DEMGENDER'
'M_DEMAFFL'
'M_DEMAGE'
'M_DEMGENDER'
) then ROLE='INPUT';
else do;
ROLE='REJECTED';
COMMENT = "Reg: Rejected using stepwise selection";
end;
end;
