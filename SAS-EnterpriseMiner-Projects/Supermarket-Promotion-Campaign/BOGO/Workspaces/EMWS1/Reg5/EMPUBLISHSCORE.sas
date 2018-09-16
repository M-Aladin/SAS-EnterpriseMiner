*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REG5DRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
format U_TargetBuy BEST12.;
*** Unnormalized target values;
ARRAY REG5DRU[2]  _TEMPORARY_ (1 0);

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

*** Check TimeSinceLastPurchase for missing values ;
if missing( TimeSinceLastPurchase ) then do;
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

*** Generate dummy variables for PreviousCampaign ;
drop _5_0 ;
if missing( PreviousCampaign ) then do;
   _5_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( PreviousCampaign , BEST12. );
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

*** Generate dummy variables for REP_Gender ;
drop _8_0 ;
if missing( REP_Gender ) then do;
   _8_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( REP_Gender , $CHAR1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      _8_0 = 1;
   end;
   else if _dm1 = 'M'  then do;
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
   _P0 = 0.3595334686;
   _P1 = 0.6404665314;
   goto REG5DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: AffluenceGrade ;
_TEMP = AffluenceGrade ;
_LP0 = _LP0 + (    0.24294344477437 * _TEMP);

***  Effect: MobileApplications ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.41175493408912) * _TEMP * _4_0;

***  Effect: PreviousCampaign ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.35065890425882) * _TEMP * _5_0;

***  Effect: REP_Age ;
_TEMP = REP_Age ;
_LP0 = _LP0 + (    -0.1992527800741 * _TEMP);

***  Effect: REP_Gender ;
_TEMP = 1;
_LP0 = _LP0 + (     0.7478700771813) * _TEMP * _8_0;

***  Effect: DayCareProducts*NightRepairProducts ;
_TEMP = DayCareProducts  * NightRepairProducts ;
_LP0 = _LP0 + (    0.14083470176539 * _TEMP);

***  Effect: CleanserProducts*CleanserProducts*TimeSinceLastPurchase ;
_TEMP = CleanserProducts  * CleanserProducts  * TimeSinceLastPurchase ;
_LP0 = _LP0 + (    0.00514856895802 * _TEMP);

***  Effect: REP_Age*REP_Age*REP_Age ;
_TEMP = REP_Age  * REP_Age  * REP_Age ;
_LP0 = _LP0 + (    0.00001667414641 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =     4.16952745994821 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG5DR1:


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
I_TargetBuy = REG5DRF[_IY];
U_TargetBuy = REG5DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
