*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

length I_TargetBuy $ 12;
label I_TargetBuy = 'Into: TargetBuy' ;
*** Target Values;
array REG7DRF [2] $12 _temporary_ ('1' '0' );
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
format U_TargetBuy BEST12.;
*** Unnormalized target values;
ARRAY REG7DRU[2]  _TEMPORARY_ (1 0);

drop _DM_BAD;
_DM_BAD=0;

*** Check AffluenceGrade for missing values ;
if missing( AffluenceGrade ) then do;
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
   if _dm12 = '1'  then do;
      _4_0 = -1;
   end;
   else if _dm12 = '0'  then do;
      _4_0 = 1;
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
   if _dm12 = '1'  then do;
      _5_0 = -1;
   end;
   else if _dm12 = '0'  then do;
      _5_0 = 1;
   end;
   else do;
      _5_0 = .;
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
   _P0 = 0.428802589;
   _P1 = 0.571197411;
   goto REG7DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: AffluenceGrade ;
_TEMP = AffluenceGrade ;
_LP0 = _LP0 + (    0.27732912059485 * _TEMP);

***  Effect: DayCareProducts ;
_TEMP = DayCareProducts ;
_LP0 = _LP0 + (    0.33546558114046 * _TEMP);

***  Effect: MobileApplications ;
_TEMP = 1;
_LP0 = _LP0 + (   -0.89781219270914) * _TEMP * _4_0;

***  Effect: NightRepairProducts ;
_TEMP = NightRepairProducts ;
_LP0 = _LP0 + (    0.39917676284553 * _TEMP);

***  Effect: PreviousCampaign ;
_TEMP = 1;
_LP0 = _LP0 + (    -0.6329253377733) * _TEMP * _5_0;

***  Effect: REP_Age ;
_TEMP = REP_Age ;
_LP0 = _LP0 + (   -0.06267306364606 * _TEMP);

***  Effect: REP_ClusterGroup ;
_TEMP = 1;
_LP0 = _LP0 + (    0.25266211269594) * _TEMP * _7_0;
_LP0 = _LP0 + (    0.09203555761921) * _TEMP * _7_1;
_LP0 = _LP0 + (    0.31706141121511) * _TEMP * _7_2;
_LP0 = _LP0 + (    -0.3099952072709) * _TEMP * _7_3;
_LP0 = _LP0 + (   -0.05907113530226) * _TEMP * _7_4;
_LP0 = _LP0 + (   -0.20084605523112) * _TEMP * _7_5;

***  Effect: REP_Gender ;
_TEMP = 1;
_LP0 = _LP0 + (    1.17618847178625) * _TEMP * _8_0;
_LP0 = _LP0 + (   -0.47020118225909) * _TEMP * _8_1;

*** Naive Posterior Probabilities;
drop _MAXP _IY _P0 _P1;
_TEMP =    -1.90985711204032 + _LP0;
if (_TEMP < 0) then do;
   _TEMP = exp(_TEMP);
   _P0 = _TEMP / (1 + _TEMP);
end;
else _P0 = 1 / (1 + exp(-_TEMP));
_P1 = 1.0 - _P0;

REG7DR1:


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
I_TargetBuy = REG7DRF[_IY];
U_TargetBuy = REG7DRU[_IY];

*************************************;
***** end scoring code for regression;
*************************************;
