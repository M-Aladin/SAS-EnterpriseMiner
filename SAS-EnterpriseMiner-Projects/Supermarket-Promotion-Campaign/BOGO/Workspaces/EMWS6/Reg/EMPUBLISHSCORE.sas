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

*** Generate dummy variables for M_DemAffl ;
drop _5_0 ;
if missing( M_DemAffl ) then do;
   _5_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemAffl , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _5_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _5_0 = -1;
   end;
   else do;
      _5_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemAge ;
drop _6_0 ;
if missing( M_DemAge ) then do;
   _6_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemAge , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _6_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _6_0 = -1;
   end;
   else do;
      _6_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemGender ;
drop _8_0 ;
if missing( M_DemGender ) then do;
   _8_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemGender , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _8_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _8_0 = -1;
   end;
   else do;
      _8_0 = .;
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
_LP0 = _LP0 + (    0.24944366493606 * _TEMP);

***  Effect: IMP_DemAge ;
_TEMP = IMP_DemAge ;
_LP0 = _LP0 + (   -0.05486504428706 * _TEMP);

***  Effect: IMP_DemGender ;
_TEMP = 1;
_LP0 = _LP0 + (    0.93935090524855) * _TEMP * _2_0;
_LP0 = _LP0 + (    0.06253513692816) * _TEMP * _2_1;

***  Effect: M_DemAffl ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.17244482563717) * _TEMP * _5_0;

***  Effect: M_DemAge ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.11432703065309) * _TEMP * _6_0;

***  Effect: M_DemGender ;
_TEMP = 1;
_LP0 = _LP0 + (    0.78110321809995) * _TEMP * _8_0;

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.61224667807204 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REGDR1:



*** Decision Processing;
label D_TARGETBUY = 'Decision: TargetBuy' ;
label EP_TARGETBUY = 'Expected Profit: TargetBuy' ;

length D_TARGETBUY $ 7;

D_TARGETBUY = ' ';
EP_TARGETBUY = .;

*** Compute Expected Consequences and Choose Decision;
_decnum = 1; drop _decnum;

D_TARGETBUY = '1' ;
EP_TARGETBUY = _P0 * 15 + _P1 * -0.5;
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
