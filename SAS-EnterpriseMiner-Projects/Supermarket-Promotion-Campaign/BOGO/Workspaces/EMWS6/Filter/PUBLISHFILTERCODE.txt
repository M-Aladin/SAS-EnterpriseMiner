
length _FILTERNORM1  $32;
drop _FILTERNORM1 ;
%dmnormcp(DemClusterGroup,_FILTERNORM1);

length _FILTERNORM2  $32;
drop _FILTERNORM2 ;
%dmnormcp(DemTVReg,_FILTERNORM2);
if
_FILTERNORM1 not in ( 'U')
 and
_FILTERNORM2 not in ( 'BORDER')
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
