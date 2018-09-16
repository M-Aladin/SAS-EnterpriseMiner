*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REG8DRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
format U_TargetBuy BEST12.;
*** Unnormalized target values;
ARRAY REG8DRU[2]  _TEMPORARY_ (1 0);

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

*** Generate dummy variables for REP_ClusterGroup ;
drop _7_0 _7_1 _7_2 _7_3 _7_4 _7_5 ;
*** encoding is sparse, initialize to zero;
_7_0 = 0;
_7_1 = 0;
_7_2 = 0;
_7_3 = 0;
_7_4 = 0;
_7_5 = 0;
if missing( REP_ClusterGroup ) then do;
   _7_0 = .;
   _7_1 = .;
   _7_2 = .;
   _7_3 = .;
   _7_4 = .;
   _7_5 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( REP_ClusterGroup , $CHAR1. );
   %DMNORMIP( _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'D'  then do;
      if _dm1 <= 'B'  then do;
         if _dm1 = 'A'  then do;
            _7_0 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               _7_1 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            _7_2 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               _7_3 = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            _7_4 = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               _7_5 = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            _7_0 = -1;
            _7_1 = -1;
            _7_2 = -1;
            _7_3 = -1;
            _7_4 = -1;
            _7_5 = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      _7_0 = .;
      _7_1 = .;
      _7_2 = .;
      _7_3 = .;
      _7_4 = .;
      _7_5 = .;
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
   _P0 = 0.2605566219;
   _P1 = 0.7394433781;
   goto REG8DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: AffluenceGrade ;
_TEMP = AffluenceGrade ;
_LP0 = _LP0 + (    0.23178562399284 * _TEMP);

***  Effect: MobileApplications ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.16430354375296) * _TEMP * _4_0;

***  Effect: NightRepairProducts ;
_TEMP = NightRepairProducts ;
_LP0 = _LP0 + (    0.16467224208898 * _TEMP);

***  Effect: REP_Age ;
_TEMP = REP_Age ;
_LP0 = _LP0 + (   -0.06115067281912 * _TEMP);

***  Effect: REP_ClusterGroup ;
_TEMP = 1;
_LP0 = _LP0 + (    0.22774389488727) * _TEMP * _7_0;
_LP0 = _LP0 + (    0.10874894887071) * _TEMP * _7_1;
_LP0 = _LP0 + (    0.05686242417814) * _TEMP * _7_2;
_LP0 = _LP0 + (    0.38916810135115) * _TEMP * _7_3;
_LP0 = _LP0 + (   -0.03193696233128) * _TEMP * _7_4;
_LP0 = _LP0 + (   -0.24875241509855) * _TEMP * _7_5;

***  Effect: REP_Gender ;
_TEMP = 1;
_LP0 = _LP0 + (    1.00050246389455) * _TEMP * _8_0;
_LP0 = _LP0 + (   -0.31571882344155) * _TEMP * _8_1;

***  Effect: TimeSinceLastPurchase ;
_TEMP = TimeSinceLastPurchase ;
_LP0 = _LP0 + (    0.06390829868418 * _TEMP);

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -0.89191650770041 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG8DR1:

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
I_TargetBuy = REG8DRF[_IY];
U_TargetBuy = REG8DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
