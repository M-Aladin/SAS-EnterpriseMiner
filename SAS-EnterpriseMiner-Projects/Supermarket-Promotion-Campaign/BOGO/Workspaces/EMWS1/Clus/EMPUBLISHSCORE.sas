*****************************************;
*** Begin Scoring Code from PROC DMVQ ***;
*****************************************;


*** Begin Class Look-up, Standardization, Replacement ;
drop _dm_bad; _dm_bad = 0;

*** Standardize AffluenceGrade ;
drop T_AffluenceGrade ;
if missing( AffluenceGrade ) then T_AffluenceGrade = .;
else T_AffluenceGrade = (AffluenceGrade
         - 9.03835227272727) * 0.27836915260968;

*** Standardize NightRepairProducts ;
drop T_NightRepairProducts ;
if missing( NightRepairProducts ) then T_NightRepairProducts = .;
else T_NightRepairProducts = (NightRepairProducts
         - 0.98910984848484) * 1.22167521817256;

*** Standardize REP_Age ;
drop T_REP_Age ;
if missing( REP_Age ) then T_REP_Age = .;
else T_REP_Age = (REP_Age - 54.3913352272727) * 0.07234951721046;

*** Standardize TimeSinceLastPurchase ;
drop T_TimeSinceLastPurchase ;
if missing( TimeSinceLastPurchase ) then T_TimeSinceLastPurchase = .;
else T_TimeSinceLastPurchase = (TimeSinceLastPurchase
         - 3.75236742424242) * 0.24727221489258;

*** Generate dummy variables for LoyaltyClass ;
drop LoyaltyClassGold LoyaltyClassPlatinum ;
if missing( LoyaltyClass ) then do;
   LoyaltyClassGold = .;
   LoyaltyClassPlatinum = .;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( LoyaltyClass , $CHAR8. );
   %DMNORMIP( _dm8 )
   if _dm8 = 'GOLD'  then do;
      LoyaltyClassGold = 0.54076433269938;
      LoyaltyClassPlatinum = -0.54076433269938;
   end;
   else if _dm8 = 'PLATINUM'  then do;
      LoyaltyClassGold = -0.92439829803968;
      LoyaltyClassPlatinum = 0.92439829803968;
   end;
   else do;
      LoyaltyClassGold = .;
      LoyaltyClassPlatinum = .;
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_Gender ;
drop REP_GenderF REP_GenderM ;
if missing( REP_Gender ) then do;
   REP_GenderF = .;
   REP_GenderM = .;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( REP_Gender , $CHAR1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      REP_GenderF = 0.4748373236048;
      REP_GenderM = -0.4748373236048;
   end;
   else if _dm1 = 'M'  then do;
      REP_GenderF = -1.05274291623274;
      REP_GenderM = 1.05274291623274;
   end;
   else do;
      REP_GenderF = .;
      REP_GenderM = .;
      _DM_BAD = 1;
   end;
end;

*** End Class Look-up, Standardization, Replacement ;


*** Omitted Cases;
if _dm_bad then do;
   _SEGMENT_ = .; Distance = .;
   goto CLUSvlex ;
end; *** omitted;

*** Compute Distances and Cluster Membership;
label _SEGMENT_ = 'Segment Id' ;
label Distance = 'Distance' ;
array CLUSvads [4] _temporary_;
drop _vqclus _vqmvar _vqnvar;
_vqmvar = 0;
do _vqclus = 1 to 4; CLUSvads [_vqclus] = 0; end;
if not missing( T_AffluenceGrade ) then do;
   CLUSvads [1] + ( T_AffluenceGrade - -0.20822839151178 )**2;
   CLUSvads [2] + ( T_AffluenceGrade - -0.39889226098119 )**2;
   CLUSvads [3] + ( T_AffluenceGrade - 1.26152871890932 )**2;
   CLUSvads [4] + ( T_AffluenceGrade - -0.18609250990891 )**2;
end;
else _vqmvar + 1;
if not missing( T_NightRepairProducts ) then do;
   CLUSvads [1] + ( T_NightRepairProducts - -0.02610464977736 )**2;
   CLUSvads [2] + ( T_NightRepairProducts - -0.06836031465772 )**2;
   CLUSvads [3] + ( T_NightRepairProducts - 0.1848459255296 )**2;
   CLUSvads [4] + ( T_NightRepairProducts - -0.01419033782218 )**2;
end;
else _vqmvar + 1;
if not missing( T_REP_Age ) then do;
   CLUSvads [1] + ( T_REP_Age - 0.90822991401443 )**2;
   CLUSvads [2] + ( T_REP_Age - 0.01033849847687 )**2;
   CLUSvads [3] + ( T_REP_Age - -0.86523516879227 )**2;
   CLUSvads [4] + ( T_REP_Age - 0.36936518921616 )**2;
end;
else _vqmvar + 1;
if not missing( T_TimeSinceLastPurchase ) then do;
   CLUSvads [1] + ( T_TimeSinceLastPurchase - 3.50936962445003 )**2;
   CLUSvads [2] + ( T_TimeSinceLastPurchase - -0.1520479611318 )**2;
   CLUSvads [3] + ( T_TimeSinceLastPurchase - -0.2337428682614 )**2;
   CLUSvads [4] + ( T_TimeSinceLastPurchase - -0.21609064628662 )**2;
end;
else _vqmvar + 1;
if not missing( LoyaltyClassGold ) then do;
   CLUSvads [1] + ( LoyaltyClassGold - -0.14792962276321 )**2;
   CLUSvads [2] + ( LoyaltyClassGold - 0.54076433269938 )**2;
   CLUSvads [3] + ( LoyaltyClassGold - 0.31893262792326 )**2;
   CLUSvads [4] + ( LoyaltyClassGold - -0.9243982980397 )**2;
end;
else _vqmvar + 0.5;
if not missing( LoyaltyClassPlatinum ) then do;
   CLUSvads [1] + ( LoyaltyClassPlatinum - 0.14792962276321 )**2;
   CLUSvads [2] + ( LoyaltyClassPlatinum - -0.54076433269938 )**2;
   CLUSvads [3] + ( LoyaltyClassPlatinum - -0.31893262792326 )**2;
   CLUSvads [4] + ( LoyaltyClassPlatinum - 0.9243982980397 )**2;
end;
else _vqmvar + 0.5;
if not missing( REP_GenderF ) then do;
   CLUSvads [1] + ( REP_GenderF - -0.03200957624912 )**2;
   CLUSvads [2] + ( REP_GenderF - -0.10984298382627 )**2;
   CLUSvads [3] + ( REP_GenderF - 0.35546597397159 )**2;
   CLUSvads [4] + ( REP_GenderF - -0.06033144759109 )**2;
end;
else _vqmvar + 0.5;
if not missing( REP_GenderM ) then do;
   CLUSvads [1] + ( REP_GenderM - 0.03200957624912 )**2;
   CLUSvads [2] + ( REP_GenderM - 0.10984298382627 )**2;
   CLUSvads [3] + ( REP_GenderM - -0.35546597397159 )**2;
   CLUSvads [4] + ( REP_GenderM - 0.06033144759109 )**2;
end;
else _vqmvar + 0.5;
_vqnvar = 6 - _vqmvar;
if _vqnvar <= 5.4569682106375E-12 then do;
   _SEGMENT_ = .; Distance = .;
end;
else do;
   _SEGMENT_ = 1; Distance = CLUSvads [1];
   _vqfzdst = Distance * 0.99999999999988; drop _vqfzdst;
   do _vqclus = 2 to 4;
      if CLUSvads [_vqclus] < _vqfzdst then do;
         _SEGMENT_ = _vqclus; Distance = CLUSvads [_vqclus];
         _vqfzdst = Distance * 0.99999999999988;
      end;
   end;
   Distance = sqrt(Distance * (6 / _vqnvar));
end;
CLUSvlex :;

***************************************;
*** End Scoring Code from PROC DMVQ ***;
***************************************;
*------------------------------------------------------------*;
* Clus: Creating Segment Label;
*------------------------------------------------------------*;
length _SEGMENT_LABEL_ $80;
label _SEGMENT_LABEL_='Segment Description';
if _SEGMENT_ = 1 then _SEGMENT_LABEL_="Cluster1";
else
if _SEGMENT_ = 2 then _SEGMENT_LABEL_="Cluster2";
else
if _SEGMENT_ = 3 then _SEGMENT_LABEL_="Cluster3";
else
if _SEGMENT_ = 4 then _SEGMENT_LABEL_="Cluster4";
