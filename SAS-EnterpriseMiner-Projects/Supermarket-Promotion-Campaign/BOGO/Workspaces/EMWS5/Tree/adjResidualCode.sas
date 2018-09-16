*------------------------------------------------------------*;
*Computing Unadjusted Residual Vars: TargetBuy;
*------------------------------------------------------------*;
Label R_TargetBuy1='Residual: TargetBuy=1';
Label R_TargetBuy0='Residual: TargetBuy=0';
if 
 F_TargetBuy ne '1'
and F_TargetBuy ne '0'
 then do;
R_TargetBuy1=.;
R_TargetBuy0=.;
end;
else do;
R_TargetBuy1= - Q_TargetBuy1;
R_TargetBuy0= - Q_TargetBuy0;
select(F_TargetBuy);
when('1')R_TargetBuy1= R_TargetBuy1+1;
when('0')R_TargetBuy0= R_TargetBuy0+1;
otherwise;
end;
end;
