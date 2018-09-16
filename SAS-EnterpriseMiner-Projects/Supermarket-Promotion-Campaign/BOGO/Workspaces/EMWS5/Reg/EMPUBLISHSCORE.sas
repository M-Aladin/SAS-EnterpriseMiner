*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REGDRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
*** Unnormalized target values;
ARRAY REGDRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check IMP_DemAffl for missing values ;
if missing( IMP_DemAffl ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check IMP_DemAge for missing values ;
if missing( IMP_DemAge ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for IMP_DemGender ;
drop _2_0 _2_1 ;
if missing( IMP_DemGender ) then do;
   _2_0 = .;
   _2_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   %DMNORMCP( IMP_DemGender , _dm1 )
   if _dm1 = 'F'  then do;
      _2_0 = 1;
      _2_1 = 0;
   end;
   else if _dm1 = 'M'  then do;
      _2_0 = 0;
      _2_1 = 1;
   end;
   else if _dm1 = 'U'  then do;
      _2_0 = -1;
      _2_1 = -1;
   end;
   else do;
      _2_0 = .;
      _2_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.24775018;
   _P1 = 0.75224982;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: IMP_DemAffl ;
_TEMP = IMP_DemAffl ;
_LP0 = _LP0 + (    0.24816315497633 * _TEMP);

***  Effect: IMP_DemAge ;
_TEMP = IMP_DemAge ;
_LP0 = _LP0 + (    -0.0544677225359 * _TEMP);

***  Effect: IMP_DemGender ;
_TEMP = 1;
_LP0 = _LP0 + (    0.86062032057603) * _TEMP * _2_0;
_LP0 = _LP0 + (   -0.01705845003967) * _TEMP * _2_1;

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.01040849026454 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:



*** Update Posterior Probabilities;
_P0 = _P0 * 0.05 / 0.2477501799856;
_P1 = _P1 * 0.95 / 0.75224982001439;
drop _sum; _sum = _P0 + _P1 ;
if _sum > 4.135903E-25 then do;
   _P0 = _P0 / _sum;
   _P1 = _P1 / _sum;
end;

*** Decision Processing;
label D_TARGETBUY = 'Decision: TargetBuy' ;
label EP_TARGETBUY = 'Expected Profit: TargetBuy' ;

length D_TARGETBUY $ 7;

D_TARGETBUY = ' ';
EP_TARGETBUY = .;

*** Compute Expected Consequences and Choose Decision;
_decnum = 1; drop _decnum;

D_TARGETBUY = '1' ;
EP_TARGETBUY = _P0 * 15 + _P1 * -1.5;
drop _sum; 
_sum = _P0 * 0 + _P1 * 0;
if _sum > EP_TARGETBUY + 6.82121E-12 then do;
   EP_TARGETBUY = _sum; _decnum = 2;
   D_TARGETBUY = '0' ;
end;


*** End Decision Processing ;

*** Posterior Probabilities and Predicted Level;
label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;
label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;
P_TargetBuy1 = _P0;
_MAXP = _P0;
_IY = 1;
P_TargetBuy0 = _P1;
if (_P1 >  _MAXP + 1E-8) then do;
   _MAXP = _P1;
   _IY = 2;
end;
I_TargetBuy = REGDRF[_IY];
U_TargetBuy = REGDRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
