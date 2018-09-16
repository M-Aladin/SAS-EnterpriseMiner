*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REG9DRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
format U_TargetBuy BEST12.;
*** Unnormalized target values;
ARRAY REG9DRU[2]  _TEMPORARY_ (1 0);

*** Generate dummy variables for TargetBuy ;
drop _Y ;
label F_TargetBuy = 'From: TargetBuy' ;
length F_TargetBuy $ 12;
F_TargetBuy = put( TargetBuy , BEST12. );
%DMNORMIP( F_TargetBuy )
if missing( TargetBuy ) then do;
   _Y = .;
end;
else do;
   if F_TargetBuy = '0'  then do;
      _Y = 1;
   end;
   else if F_TargetBuy = '1'  then do;
      _Y = 0;
   end;
   else do;
      _Y = .;
   end;
end;

drop _DM_BAD;
_DM_BAD=0;

*** Check AffluenceGrade for missing values ;
if missing( AffluenceGrade ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check CleanserProducts for missing values ;
if missing( CleanserProducts ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check DayCareProducts for missing values ;
if missing( DayCareProducts ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check LotionProducts for missing values ;
if missing( LotionProducts ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check NightRepairProducts for missing values ;
if missing( NightRepairProducts ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_Age for missing values ;
if missing( REP_Age ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check REP_LoyaltyTime for missing values ;
if missing( REP_LoyaltyTime ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for MobileApplications ;
drop _4_0 ;
if missing( MobileApplications ) then do;
   _4_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( MobileApplications , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      _4_0 = 1;
   end;
   else if _dm12 = '1'  then do;
      _4_0 = -1;
   end;
   else do;
      _4_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_Gender ;
drop _8_0 _8_1 ;
if missing( REP_Gender ) then do;
   _8_0 = .;
   _8_1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( REP_Gender , $CHAR1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      _8_0 = 1;
      _8_1 = 0;
   end;
   else if _dm1 = 'M'  then do;
      _8_0 = 0;
      _8_1 = 1;
   end;
   else if _dm1 = 'U'  then do;
      _8_0 = -1;
      _8_1 = -1;
   end;
   else do;
      _8_0 = .;
      _8_1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _P0 = 0.1925801012;
   _P1 = 0.8074198988;
   goto REG9DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: AffluenceGrade ;
_TEMP = AffluenceGrade ;
_LP0 = _LP0 + (    0.20893046118519 * _TEMP);

***  Effect: CleanserProducts ;
_TEMP = CleanserProducts ;
_LP0 = _LP0 + (    0.12143128460249 * _TEMP);

***  Effect: DayCareProducts ;
_TEMP = DayCareProducts ;
_LP0 = _LP0 + (    0.12936616742004 * _TEMP);

***  Effect: LotionProducts ;
_TEMP = LotionProducts ;
_LP0 = _LP0 + (   -0.09099032429357 * _TEMP);

***  Effect: MobileApplications ;
_TEMP = 1;
_LP0 = _LP0 + (    -0.3645061306092) * _TEMP * _4_0;

***  Effect: NightRepairProducts ;
_TEMP = NightRepairProducts ;
_LP0 = _LP0 + (    0.37377100853391 * _TEMP);

***  Effect: REP_Age ;
_TEMP = REP_Age ;
_LP0 = _LP0 + (   -0.05693153689918 * _TEMP);

***  Effect: REP_Gender ;
_TEMP = 1;
_LP0 = _LP0 + (    0.92960431677958) * _TEMP * _8_0;
_LP0 = _LP0 + (   -0.22937013440046) * _TEMP * _8_1;

***  Effect: REP_LoyaltyTime ;
_TEMP = REP_LoyaltyTime ;
_LP0 = _LP0 + (     0.0272649887969 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.48391929419233 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG9DR1:

*** Residuals;
if (_Y = .) then do;
   R_TargetBuy1 = .;
   R_TargetBuy0 = .;
end;
else do;
    label R_TargetBuy1 = 'Residual: TargetBuy=1' ;
    label R_TargetBuy0 = 'Residual: TargetBuy=0' ;
   R_TargetBuy1 = - _P0;
   R_TargetBuy0 = - _P1;
   select( _Y );
      when (0)  R_TargetBuy1 = R_TargetBuy1 + 1;
      when (1)  R_TargetBuy0 = R_TargetBuy0 + 1;
   end;
end;

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
I_TargetBuy = REG9DRF[_IY];
U_TargetBuy = REG9DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
