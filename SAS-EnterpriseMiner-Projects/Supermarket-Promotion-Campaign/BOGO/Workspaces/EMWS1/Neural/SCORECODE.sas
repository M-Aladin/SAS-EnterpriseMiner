***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4 
;
      label S_AffluenceGrade = 'Standard: AffluenceGrade' ;

      label S_CleanserProducts = 'Standard: CleanserProducts' ;

      label S_DayCareProducts = 'Standard: DayCareProducts' ;

      label S_LotionProducts = 'Standard: LotionProducts' ;

      label S_NightRepairProducts = 'Standard: NightRepairProducts' ;

      label S_REP_Age = 'Standard: REP_Age' ;

      label S_REP_LoyaltyTime = 'Standard: REP_LoyaltyTime' ;

      label S_TimeSinceLastPurchase = 'Standard: TimeSinceLastPurchase' ;

      label S_TotalSpend = 'Standard: TotalSpend' ;

      label CampaignViewedEmail0 = 'Dummy: CampaignViewedEmail=0' ;

      label MobileApplications0 = 'Dummy: MobileApplications=0' ;

      label PreviousCampaign0 = 'Dummy: PreviousCampaign=0' ;

      label LoyaltyClassGold = 'Dummy: LoyaltyClass=Gold' ;

      label REP_AdvertisementZonBorder = 
'Dummy: REP_AdvertisementZone=Border' ;

      label REP_AdvertisementZonCentral_Z1 = 
'Dummy: REP_AdvertisementZone=Central Z1' ;

      label REP_AdvertisementZonE_Central = 
'Dummy: REP_AdvertisementZone=E Central' ;

      label REP_AdvertisementZonN_Central = 
'Dummy: REP_AdvertisementZone=N Central' ;

      label REP_AdvertisementZonN_East = 
'Dummy: REP_AdvertisementZone=N East' ;

      label REP_AdvertisementZonN_West = 
'Dummy: REP_AdvertisementZone=N West' ;

      label REP_AdvertisementZonNE_Z1 = 'Dummy: REP_AdvertisementZone=NE Z1' ;

      label REP_AdvertisementZonNE_Z2 = 'Dummy: REP_AdvertisementZone=NE Z2' ;

      label REP_AdvertisementZonNE_Z3 = 'Dummy: REP_AdvertisementZone=NE Z3' ;

      label REP_AdvertisementZonS_Central = 
'Dummy: REP_AdvertisementZone=S Central' ;

      label REP_AdvertisementZonS_East = 
'Dummy: REP_AdvertisementZone=S East' ;

      label REP_AdvertisementZonS_West = 
'Dummy: REP_AdvertisementZone=S West' ;

      label REP_AdvertisementZonU = 'Dummy: REP_AdvertisementZone=U' ;

      label REP_ClusterGroupA = 'Dummy: REP_ClusterGroup=A' ;

      label REP_ClusterGroupB = 'Dummy: REP_ClusterGroup=B' ;

      label REP_ClusterGroupC = 'Dummy: REP_ClusterGroup=C' ;

      label REP_ClusterGroupD = 'Dummy: REP_ClusterGroup=D' ;

      label REP_ClusterGroupE = 'Dummy: REP_ClusterGroup=E' ;

      label REP_ClusterGroupF = 'Dummy: REP_ClusterGroup=F' ;

      label REP_GenderF = 'Dummy: REP_Gender=F' ;

      label REP_RegionCentral = 'Dummy: REP_Region=Central' ;

      label REP_RegionNorth = 'Dummy: REP_Region=North' ;

      label REP_RegionNorthEast = 'Dummy: REP_Region=NorthEast' ;

      label REP_RegionSouth_East = 'Dummy: REP_Region=South East' ;

      label REP_RegionSouth_West = 'Dummy: REP_Region=South West' ;

      label H101 = 'Hidden: H1=1' ;

      label H102 = 'Hidden: H1=2' ;

      label H103 = 'Hidden: H1=3' ;

      label H104 = 'Hidden: H1=4' ;

      label H105 = 'Hidden: H1=5' ;

      label H106 = 'Hidden: H1=6' ;

      label H107 = 'Hidden: H1=7' ;

      label H108 = 'Hidden: H1=8' ;

      label H109 = 'Hidden: H1=9' ;

      label H110 = 'Hidden: H1=10' ;

      label H111 = 'Hidden: H1=11' ;

      label H112 = 'Hidden: H1=12' ;

      label H113 = 'Hidden: H1=13' ;

      label H114 = 'Hidden: H1=14' ;

      label H115 = 'Hidden: H1=15' ;

      label H116 = 'Hidden: H1=16' ;

      label H117 = 'Hidden: H1=17' ;

      label H118 = 'Hidden: H1=18' ;

      label H119 = 'Hidden: H1=19' ;

      label H120 = 'Hidden: H1=20' ;

      label H121 = 'Hidden: H1=21' ;

      label H122 = 'Hidden: H1=22' ;

      label H123 = 'Hidden: H1=23' ;

      label H124 = 'Hidden: H1=24' ;

      label H125 = 'Hidden: H1=25' ;

      label H126 = 'Hidden: H1=26' ;

      label H127 = 'Hidden: H1=27' ;

      label H128 = 'Hidden: H1=28' ;

      label H129 = 'Hidden: H1=29' ;

      label H130 = 'Hidden: H1=30' ;

      label H131 = 'Hidden: H1=31' ;

      label H132 = 'Hidden: H1=32' ;

      label I_TargetBuy = 'Into: TargetBuy' ;

      label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;

      label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;

      label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for CampaignViewedEmail ;
drop CampaignViewedEmail0 ;
if missing( CampaignViewedEmail ) then do;
   CampaignViewedEmail0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( CampaignViewedEmail , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      CampaignViewedEmail0 = 1;
   end;
   else if _dm12 = '1'  then do;
      CampaignViewedEmail0 = -1;
   end;
   else do;
      CampaignViewedEmail0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for MobileApplications ;
drop MobileApplications0 ;
if missing( MobileApplications ) then do;
   MobileApplications0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( MobileApplications , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      MobileApplications0 = 1;
   end;
   else if _dm12 = '1'  then do;
      MobileApplications0 = -1;
   end;
   else do;
      MobileApplications0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for PreviousCampaign ;
drop PreviousCampaign0 ;
if missing( PreviousCampaign ) then do;
   PreviousCampaign0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( PreviousCampaign , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      PreviousCampaign0 = 1;
   end;
   else if _dm12 = '1'  then do;
      PreviousCampaign0 = -1;
   end;
   else do;
      PreviousCampaign0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for LoyaltyClass ;
drop LoyaltyClassGold ;
if missing( LoyaltyClass ) then do;
   LoyaltyClassGold = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   _dm8 = put( LoyaltyClass , $CHAR8. );
   %DMNORMIP( _dm8 )
   if _dm8 = 'GOLD'  then do;
      LoyaltyClassGold = 1;
   end;
   else if _dm8 = 'PLATINUM'  then do;
      LoyaltyClassGold = -1;
   end;
   else do;
      LoyaltyClassGold = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_AdvertisementZone ;
drop REP_AdvertisementZonBorder REP_AdvertisementZonCentral_Z1 
        REP_AdvertisementZonE_Central REP_AdvertisementZonN_Central 
        REP_AdvertisementZonN_East REP_AdvertisementZonN_West 
        REP_AdvertisementZonNE_Z1 REP_AdvertisementZonNE_Z2 
        REP_AdvertisementZonNE_Z3 REP_AdvertisementZonS_Central 
        REP_AdvertisementZonS_East REP_AdvertisementZonS_West 
        REP_AdvertisementZonU ;
*** encoding is sparse, initialize to zero;
REP_AdvertisementZonBorder = 0;
REP_AdvertisementZonCentral_Z1 = 0;
REP_AdvertisementZonE_Central = 0;
REP_AdvertisementZonN_Central = 0;
REP_AdvertisementZonN_East = 0;
REP_AdvertisementZonN_West = 0;
REP_AdvertisementZonNE_Z1 = 0;
REP_AdvertisementZonNE_Z2 = 0;
REP_AdvertisementZonNE_Z3 = 0;
REP_AdvertisementZonS_Central = 0;
REP_AdvertisementZonS_East = 0;
REP_AdvertisementZonS_West = 0;
REP_AdvertisementZonU = 0;
if missing( REP_AdvertisementZone ) then do;
   REP_AdvertisementZonBorder = .;
   REP_AdvertisementZonCentral_Z1 = .;
   REP_AdvertisementZonE_Central = .;
   REP_AdvertisementZonN_Central = .;
   REP_AdvertisementZonN_East = .;
   REP_AdvertisementZonN_West = .;
   REP_AdvertisementZonNE_Z1 = .;
   REP_AdvertisementZonNE_Z2 = .;
   REP_AdvertisementZonNE_Z3 = .;
   REP_AdvertisementZonS_Central = .;
   REP_AdvertisementZonS_East = .;
   REP_AdvertisementZonS_West = .;
   REP_AdvertisementZonU = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( REP_AdvertisementZone , $CHAR10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'E CENTRAL'  then do;
      REP_AdvertisementZonE_Central = 1;
   end;
   else if _dm10 = 'S CENTRAL'  then do;
      REP_AdvertisementZonS_Central = 1;
   end;
   else if _dm10 = 'S EAST'  then do;
      REP_AdvertisementZonS_East = 1;
   end;
   else if _dm10 = 'N WEST'  then do;
      REP_AdvertisementZonN_West = 1;
   end;
   else if _dm10 = 'W CENTRAL'  then do;
      REP_AdvertisementZonBorder = -1;
      REP_AdvertisementZonCentral_Z1 = -1;
      REP_AdvertisementZonE_Central = -1;
      REP_AdvertisementZonN_Central = -1;
      REP_AdvertisementZonN_East = -1;
      REP_AdvertisementZonN_West = -1;
      REP_AdvertisementZonNE_Z1 = -1;
      REP_AdvertisementZonNE_Z2 = -1;
      REP_AdvertisementZonNE_Z3 = -1;
      REP_AdvertisementZonS_Central = -1;
      REP_AdvertisementZonS_East = -1;
      REP_AdvertisementZonS_West = -1;
      REP_AdvertisementZonU = -1;
   end;
   else if _dm10 = 'CENTRAL Z1'  then do;
      REP_AdvertisementZonCentral_Z1 = 1;
   end;
   else if _dm10 = 'NE Z3'  then do;
      REP_AdvertisementZonNE_Z3 = 1;
   end;
   else if _dm10 = 'NE Z1'  then do;
      REP_AdvertisementZonNE_Z1 = 1;
   end;
   else if _dm10 = 'N EAST'  then do;
      REP_AdvertisementZonN_East = 1;
   end;
   else if _dm10 = 'S WEST'  then do;
      REP_AdvertisementZonS_West = 1;
   end;
   else if _dm10 = 'U'  then do;
      REP_AdvertisementZonU = 1;
   end;
   else if _dm10 = 'NE Z2'  then do;
      REP_AdvertisementZonNE_Z2 = 1;
   end;
   else if _dm10 = 'N CENTRAL'  then do;
      REP_AdvertisementZonN_Central = 1;
   end;
   else if _dm10 = 'BORDER'  then do;
      REP_AdvertisementZonBorder = 1;
   end;
   else do;
      REP_AdvertisementZonBorder = .;
      REP_AdvertisementZonCentral_Z1 = .;
      REP_AdvertisementZonE_Central = .;
      REP_AdvertisementZonN_Central = .;
      REP_AdvertisementZonN_East = .;
      REP_AdvertisementZonN_West = .;
      REP_AdvertisementZonNE_Z1 = .;
      REP_AdvertisementZonNE_Z2 = .;
      REP_AdvertisementZonNE_Z3 = .;
      REP_AdvertisementZonS_Central = .;
      REP_AdvertisementZonS_East = .;
      REP_AdvertisementZonS_West = .;
      REP_AdvertisementZonU = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_ClusterGroup ;
drop REP_ClusterGroupA REP_ClusterGroupB REP_ClusterGroupC REP_ClusterGroupD 
        REP_ClusterGroupE REP_ClusterGroupF ;
*** encoding is sparse, initialize to zero;
REP_ClusterGroupA = 0;
REP_ClusterGroupB = 0;
REP_ClusterGroupC = 0;
REP_ClusterGroupD = 0;
REP_ClusterGroupE = 0;
REP_ClusterGroupF = 0;
if missing( REP_ClusterGroup ) then do;
   REP_ClusterGroupA = .;
   REP_ClusterGroupB = .;
   REP_ClusterGroupC = .;
   REP_ClusterGroupD = .;
   REP_ClusterGroupE = .;
   REP_ClusterGroupF = .;
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
            REP_ClusterGroupA = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               REP_ClusterGroupB = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            REP_ClusterGroupC = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               REP_ClusterGroupD = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            REP_ClusterGroupE = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               REP_ClusterGroupF = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            REP_ClusterGroupA = -1;
            REP_ClusterGroupB = -1;
            REP_ClusterGroupC = -1;
            REP_ClusterGroupD = -1;
            REP_ClusterGroupE = -1;
            REP_ClusterGroupF = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      REP_ClusterGroupA = .;
      REP_ClusterGroupB = .;
      REP_ClusterGroupC = .;
      REP_ClusterGroupD = .;
      REP_ClusterGroupE = .;
      REP_ClusterGroupF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_Gender ;
drop REP_GenderF ;
if missing( REP_Gender ) then do;
   REP_GenderF = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   _dm1 = put( REP_Gender , $CHAR1. );
   %DMNORMIP( _dm1 )
   if _dm1 = 'F'  then do;
      REP_GenderF = 1;
   end;
   else if _dm1 = 'M'  then do;
      REP_GenderF = -1;
   end;
   else do;
      REP_GenderF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for REP_Region ;
drop REP_RegionCentral REP_RegionNorth REP_RegionNorthEast 
        REP_RegionSouth_East REP_RegionSouth_West ;
*** encoding is sparse, initialize to zero;
REP_RegionCentral = 0;
REP_RegionNorth = 0;
REP_RegionNorthEast = 0;
REP_RegionSouth_East = 0;
REP_RegionSouth_West = 0;
if missing( REP_Region ) then do;
   REP_RegionCentral = .;
   REP_RegionNorth = .;
   REP_RegionNorthEast = .;
   REP_RegionSouth_East = .;
   REP_RegionSouth_West = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( REP_Region , $CHAR10. );
   %DMNORMIP( _dm10 )
   _dm_find = 0; drop _dm_find;
   if _dm10 <= 'NORTHEAST'  then do;
      if _dm10 <= 'NORTH'  then do;
         if _dm10 = 'CENTRAL'  then do;
            REP_RegionCentral = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'NORTH'  then do;
               REP_RegionNorth = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'NORTHEAST'  then do;
            REP_RegionNorthEast = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm10 <= 'SOUTH WEST'  then do;
         if _dm10 = 'SOUTH EAST'  then do;
            REP_RegionSouth_East = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'SOUTH WEST'  then do;
               REP_RegionSouth_West = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'U'  then do;
            REP_RegionCentral = -1;
            REP_RegionNorth = -1;
            REP_RegionNorthEast = -1;
            REP_RegionSouth_East = -1;
            REP_RegionSouth_West = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      REP_RegionCentral = .;
      REP_RegionNorth = .;
      REP_RegionNorthEast = .;
      REP_RegionSouth_East = .;
      REP_RegionSouth_West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   AffluenceGrade , 
   CleanserProducts , 
   DayCareProducts , 
   LotionProducts , 
   NightRepairProducts , 
   REP_Age , 
   REP_LoyaltyTime , 
   TimeSinceLastPurchase , 
   TotalSpend   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_AffluenceGrade  =    -2.68761741215553 +     0.30589758379145 * 
        AffluenceGrade ;
   S_CleanserProducts  =    -1.42903255597987 +     0.74276547190097 * 
        CleanserProducts ;
   S_DayCareProducts  =    -1.37517902307985 +     0.91216045526857 * 
        DayCareProducts ;
   S_LotionProducts  =    -1.38069724890425 +     0.64139810950275 * 
        LotionProducts ;
   S_NightRepairProducts  =    -1.19912632892897 +     1.21017252847898 * 
        NightRepairProducts ;
   S_REP_Age  =    -4.01045434545519 +     0.07393441000334 * REP_Age ;
   S_REP_LoyaltyTime  =    -1.57799030803305 +     0.26569304025283 * 
        REP_LoyaltyTime ;
   S_TimeSinceLastPurchase  =    -1.30175224120494 +     0.40509001414804 * 
        TimeSinceLastPurchase ;
   S_TotalSpend  =     -1.0890092505783 +     0.00026346669375 * TotalSpend ;
END;
ELSE DO;
   IF MISSING( AffluenceGrade ) THEN S_AffluenceGrade  = . ;
   ELSE S_AffluenceGrade  =    -2.68761741215553 +     0.30589758379145 * 
        AffluenceGrade ;
   IF MISSING( CleanserProducts ) THEN S_CleanserProducts  = . ;
   ELSE S_CleanserProducts  =    -1.42903255597987 +     0.74276547190097 * 
        CleanserProducts ;
   IF MISSING( DayCareProducts ) THEN S_DayCareProducts  = . ;
   ELSE S_DayCareProducts  =    -1.37517902307985 +     0.91216045526857 * 
        DayCareProducts ;
   IF MISSING( LotionProducts ) THEN S_LotionProducts  = . ;
   ELSE S_LotionProducts  =    -1.38069724890425 +     0.64139810950275 * 
        LotionProducts ;
   IF MISSING( NightRepairProducts ) THEN S_NightRepairProducts  = . ;
   ELSE S_NightRepairProducts
          =    -1.19912632892897 +     1.21017252847898 * NightRepairProducts
         ;
   IF MISSING( REP_Age ) THEN S_REP_Age  = . ;
   ELSE S_REP_Age  =    -4.01045434545519 +     0.07393441000334 * REP_Age ;
   IF MISSING( REP_LoyaltyTime ) THEN S_REP_LoyaltyTime  = . ;
   ELSE S_REP_LoyaltyTime  =    -1.57799030803305 +     0.26569304025283 * 
        REP_LoyaltyTime ;
   IF MISSING( TimeSinceLastPurchase ) THEN S_TimeSinceLastPurchase  = . ;
   ELSE S_TimeSinceLastPurchase
          =    -1.30175224120494 +     0.40509001414804 * 
        TimeSinceLastPurchase ;
   IF MISSING( TotalSpend ) THEN S_TotalSpend  = . ;
   ELSE S_TotalSpend  =     -1.0890092505783 +     0.00026346669375 * 
        TotalSpend ;
END;
*** *************************;
*** Writing the Node bin ;
*** *************************;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H101  =    -0.17417635549602 * S_AffluenceGrade  +    -0.19426366230862 * 
        S_CleanserProducts  +     0.03671873378409 * S_DayCareProducts
          +     0.18437955302601 * S_LotionProducts  +    -0.02293536554998 * 
        S_NightRepairProducts  +    -0.05596676359277 * S_REP_Age
          +    -0.13367185656925 * S_REP_LoyaltyTime
          +     0.33790641028431 * S_TimeSinceLastPurchase
          +     0.12107661708795 * S_TotalSpend ;
   H102  =    -0.09171129410505 * S_AffluenceGrade  +    -0.07243725970957 * 
        S_CleanserProducts  +    -0.13599549886433 * S_DayCareProducts
          +    -0.00127695453113 * S_LotionProducts  +    -0.11092095674587 * 
        S_NightRepairProducts  +    -0.19120918388182 * S_REP_Age
          +    -0.17840918919563 * S_REP_LoyaltyTime
          +    -0.03916867801894 * S_TimeSinceLastPurchase
          +    -0.02001036897876 * S_TotalSpend ;
   H103  =    -0.20669661748635 * S_AffluenceGrade  +    -0.64906719373165 * 
        S_CleanserProducts  +     -0.0032990669494 * S_DayCareProducts
          +     0.21041687796265 * S_LotionProducts  +     0.23542399343192 * 
        S_NightRepairProducts  +     0.13117534533982 * S_REP_Age
          +     0.14779879154299 * S_REP_LoyaltyTime
          +    -0.03790825498831 * S_TimeSinceLastPurchase
          +     0.12063577727375 * S_TotalSpend ;
   H104  =    -0.08437300016449 * S_AffluenceGrade  +    -0.21337779484124 * 
        S_CleanserProducts  +     0.13393348183545 * S_DayCareProducts
          +    -0.07592185529507 * S_LotionProducts  +     0.00719150731557 * 
        S_NightRepairProducts  +     0.09223834416588 * S_REP_Age
          +    -0.00093882955486 * S_REP_LoyaltyTime
          +     -0.0344014051428 * S_TimeSinceLastPurchase
          +     0.09973223079397 * S_TotalSpend ;
   H105  =     0.08167684555404 * S_AffluenceGrade  +    -0.06281128238903 * 
        S_CleanserProducts  +     0.11677260158837 * S_DayCareProducts
          +     0.20013646643828 * S_LotionProducts  +    -0.16364712276657 * 
        S_NightRepairProducts  +    -0.01108724979666 * S_REP_Age
          +    -0.02460425029502 * S_REP_LoyaltyTime
          +    -0.16989085006573 * S_TimeSinceLastPurchase
          +    -0.24233503446213 * S_TotalSpend ;
   H106  =     0.07877924605529 * S_AffluenceGrade  +     0.22961120177604 * 
        S_CleanserProducts  +    -0.09672244483296 * S_DayCareProducts
          +    -0.04766138165729 * S_LotionProducts  +    -0.15012494253457 * 
        S_NightRepairProducts  +    -0.14155308213165 * S_REP_Age
          +      0.1668681838361 * S_REP_LoyaltyTime
          +     0.06119650709381 * S_TimeSinceLastPurchase
          +    -0.06766437583249 * S_TotalSpend ;
   H107  =     0.18348060255484 * S_AffluenceGrade  +     0.05280324143755 * 
        S_CleanserProducts  +    -0.03965355841151 * S_DayCareProducts
          +     0.04757945449892 * S_LotionProducts  +    -0.05981854114167 * 
        S_NightRepairProducts  +     0.17839041726623 * S_REP_Age
          +    -0.21483755993042 * S_REP_LoyaltyTime
          +    -0.19233015466344 * S_TimeSinceLastPurchase
          +    -0.09170665092504 * S_TotalSpend ;
   H108  =    -0.10903889646192 * S_AffluenceGrade  +    -0.22856055612183 * 
        S_CleanserProducts  +     0.05061938900928 * S_DayCareProducts
          +     0.02101748230057 * S_LotionProducts  +     -0.1985609483266 * 
        S_NightRepairProducts  +    -0.10550202254144 * S_REP_Age
          +     0.09099833524525 * S_REP_LoyaltyTime
          +    -0.44381470964068 * S_TimeSinceLastPurchase
          +    -0.10808163883789 * S_TotalSpend ;
   H109  =    -0.21539386282357 * S_AffluenceGrade  +    -0.00131765487676 * 
        S_CleanserProducts  +     0.22941697721903 * S_DayCareProducts
          +     0.05829428521223 * S_LotionProducts  +     0.34486516324115 * 
        S_NightRepairProducts  +    -0.02240057720538 * S_REP_Age
          +    -0.13346571307516 * S_REP_LoyaltyTime
          +     0.16700963761202 * S_TimeSinceLastPurchase
          +    -0.08813799136587 * S_TotalSpend ;
   H110  =    -0.18384160602502 * S_AffluenceGrade  +    -0.14564966349258 * 
        S_CleanserProducts  +    -0.11327137936056 * S_DayCareProducts
          +     0.09295989117972 * S_LotionProducts  +      -0.101968384988 * 
        S_NightRepairProducts  +    -0.02850494918059 * S_REP_Age
          +     0.12615925065045 * S_REP_LoyaltyTime
          +     0.05446456284909 * S_TimeSinceLastPurchase
          +    -0.54217783802813 * S_TotalSpend ;
   H111  =    -0.04007706868552 * S_AffluenceGrade  +    -0.15015542805905 * 
        S_CleanserProducts  +    -0.10062888479699 * S_DayCareProducts
          +     0.13608697386821 * S_LotionProducts  +     0.03752440042861 * 
        S_NightRepairProducts  +    -0.05427553085123 * S_REP_Age
          +     0.00059615954704 * S_REP_LoyaltyTime
          +    -0.20642903740155 * S_TimeSinceLastPurchase
          +    -0.05383111464159 * S_TotalSpend ;
   H112  =    -0.04653488184059 * S_AffluenceGrade  +     0.00622635382765 * 
        S_CleanserProducts  +     0.06376068965852 * S_DayCareProducts
          +     0.21762783174791 * S_LotionProducts  +    -0.13996785936505 * 
        S_NightRepairProducts  +    -0.19932170284367 * S_REP_Age
          +     0.02255681123765 * S_REP_LoyaltyTime
          +    -0.29576603289653 * S_TimeSinceLastPurchase
          +     0.01288806235863 * S_TotalSpend ;
   H113  =     0.05371143552928 * S_AffluenceGrade  +    -0.04296938340115 * 
        S_CleanserProducts  +    -0.12659930011758 * S_DayCareProducts
          +     0.11086104024064 * S_LotionProducts  +    -0.01770253753608 * 
        S_NightRepairProducts  +     0.09034549882634 * S_REP_Age
          +    -0.06856279689648 * S_REP_LoyaltyTime
          +    -0.29023058759892 * S_TimeSinceLastPurchase
          +    -0.30611240098643 * S_TotalSpend ;
   H114  =     0.20607606828689 * S_AffluenceGrade  +     0.22574015425986 * 
        S_CleanserProducts  +     0.24797445947866 * S_DayCareProducts
          +    -0.05232561721002 * S_LotionProducts  +    -0.24482521671637 * 
        S_NightRepairProducts  +     0.01924526595856 * S_REP_Age
          +     0.06244340176659 * S_REP_LoyaltyTime
          +    -0.00939640662466 * S_TimeSinceLastPurchase
          +     0.28945173989057 * S_TotalSpend ;
   H115  =     -0.1669155526245 * S_AffluenceGrade  +     0.21445596899272 * 
        S_CleanserProducts  +     0.45368325028898 * S_DayCareProducts
          +    -0.30621133475166 * S_LotionProducts  +     0.02115129113777 * 
        S_NightRepairProducts  +     0.06053466811758 * S_REP_Age
          +     0.02200326931129 * S_REP_LoyaltyTime
          +     0.20145609797171 * S_TimeSinceLastPurchase
          +     0.36172305812804 * S_TotalSpend ;
   H116  =    -0.34691656127464 * S_AffluenceGrade  +    -0.20620994184586 * 
        S_CleanserProducts  +    -0.09356724063063 * S_DayCareProducts
          +    -0.19288418686841 * S_LotionProducts  +     0.05369978216065 * 
        S_NightRepairProducts  +     0.19444108222064 * S_REP_Age
          +    -0.16534438843376 * S_REP_LoyaltyTime
          +    -0.14523339244944 * S_TimeSinceLastPurchase
          +     0.00649095167955 * S_TotalSpend ;
   H117  =     0.05791649794486 * S_AffluenceGrade  +    -0.03064664740129 * 
        S_CleanserProducts  +     0.09460501691108 * S_DayCareProducts
          +    -0.43343825773023 * S_LotionProducts  +     0.20734912072404 * 
        S_NightRepairProducts  +     0.20803706610418 * S_REP_Age
          +    -0.24181325590274 * S_REP_LoyaltyTime
          +     0.04368421038614 * S_TimeSinceLastPurchase
          +    -0.17210258059954 * S_TotalSpend ;
   H118  =    -0.08901721518444 * S_AffluenceGrade  +    -0.22851396839013 * 
        S_CleanserProducts  +     -0.0619889147644 * S_DayCareProducts
          +     0.10127739174621 * S_LotionProducts  +    -0.10738115083735 * 
        S_NightRepairProducts  +     0.11785818218111 * S_REP_Age
          +       0.132365458027 * S_REP_LoyaltyTime
          +    -0.27605477932796 * S_TimeSinceLastPurchase
          +    -0.01378650991331 * S_TotalSpend ;
   H119  =    -0.09563620249392 * S_AffluenceGrade  +    -0.01245440892463 * 
        S_CleanserProducts  +    -0.13534574576842 * S_DayCareProducts
          +    -0.13513067532443 * S_LotionProducts  +    -0.15289149026044 * 
        S_NightRepairProducts  +     0.07167957806586 * S_REP_Age
          +     0.13450585868617 * S_REP_LoyaltyTime
          +    -0.15240137665004 * S_TimeSinceLastPurchase
          +    -0.10073241207091 * S_TotalSpend ;
   H120  =     0.02883399509843 * S_AffluenceGrade  +    -0.14917921106916 * 
        S_CleanserProducts  +     0.24863886423968 * S_DayCareProducts
          +     0.32357604887637 * S_LotionProducts  +     0.04564747018763 * 
        S_NightRepairProducts  +     0.03056569893892 * S_REP_Age
          +     0.07171940336679 * S_REP_LoyaltyTime
          +     0.25466594969642 * S_TimeSinceLastPurchase
          +     0.03405484813144 * S_TotalSpend ;
   H121  =     0.33837686392668 * S_AffluenceGrade  +     0.22060661383349 * 
        S_CleanserProducts  +     0.28298369357863 * S_DayCareProducts
          +    -0.30023779611985 * S_LotionProducts  +    -0.06212913470488 * 
        S_NightRepairProducts  +     0.10547330980558 * S_REP_Age
          +      0.0576478565003 * S_REP_LoyaltyTime
          +    -0.07997544075638 * S_TimeSinceLastPurchase
          +     0.01703661927776 * S_TotalSpend ;
   H122  =    -0.15174451426069 * S_AffluenceGrade  +     0.08813118458483 * 
        S_CleanserProducts  +      0.0974556706249 * S_DayCareProducts
          +    -0.25297689069504 * S_LotionProducts  +    -0.05821880563874 * 
        S_NightRepairProducts  +     0.98363478011229 * S_REP_Age
          +    -0.15495727532223 * S_REP_LoyaltyTime
          +     0.15406031426582 * S_TimeSinceLastPurchase
          +     0.23508077253165 * S_TotalSpend ;
   H123  =    -0.20932498507888 * S_AffluenceGrade  +    -0.09089541034766 * 
        S_CleanserProducts  +      0.1126900374222 * S_DayCareProducts
          +     0.12304224436929 * S_LotionProducts  +    -0.05061869170609 * 
        S_NightRepairProducts  +    -0.11823530587476 * S_REP_Age
          +     0.24151275137959 * S_REP_LoyaltyTime
          +     -0.2008490051852 * S_TimeSinceLastPurchase
          +     0.03656850340134 * S_TotalSpend ;
   H124  =     0.05480741264507 * S_AffluenceGrade  +    -0.00682686598678 * 
        S_CleanserProducts  +     0.18615675186153 * S_DayCareProducts
          +    -0.11672895367854 * S_LotionProducts  +    -0.07209545765212 * 
        S_NightRepairProducts  +    -0.04356555601454 * S_REP_Age
          +    -0.07195148055853 * S_REP_LoyaltyTime
          +      0.1556565071578 * S_TimeSinceLastPurchase
          +    -0.09505285163631 * S_TotalSpend ;
   H125  =    -0.23136630569056 * S_AffluenceGrade  +     0.03087521712753 * 
        S_CleanserProducts  +     -0.2925641388494 * S_DayCareProducts
          +    -0.27870965180564 * S_LotionProducts  +    -0.12161020414438 * 
        S_NightRepairProducts  +    -0.06640843002782 * S_REP_Age
          +     0.10192573746743 * S_REP_LoyaltyTime
          +    -0.03289114500443 * S_TimeSinceLastPurchase
          +    -0.24352222587165 * S_TotalSpend ;
   H126  =    -0.06671310532034 * S_AffluenceGrade  +     0.00628877985192 * 
        S_CleanserProducts  +     0.08322221126788 * S_DayCareProducts
          +     0.00878348776367 * S_LotionProducts  +    -0.15382099982484 * 
        S_NightRepairProducts  +    -0.05716598738665 * S_REP_Age
          +     0.23650095878467 * S_REP_LoyaltyTime
          +     0.01311139977968 * S_TimeSinceLastPurchase
          +     -0.0858401176443 * S_TotalSpend ;
   H127  =    -0.01789668258692 * S_AffluenceGrade  +     0.17935141339167 * 
        S_CleanserProducts  +    -0.14883675267619 * S_DayCareProducts
          +    -0.01000013573542 * S_LotionProducts  +     0.20350546222878 * 
        S_NightRepairProducts  +    -0.10069457868799 * S_REP_Age
          +     0.02294081712893 * S_REP_LoyaltyTime
          +     0.10492977410228 * S_TimeSinceLastPurchase
          +    -0.26770314890132 * S_TotalSpend ;
   H128  =     0.20581195684585 * S_AffluenceGrade  +    -0.04407507698044 * 
        S_CleanserProducts  +    -0.05560079608097 * S_DayCareProducts
          +     0.09749005273196 * S_LotionProducts  +     0.17119385390441 * 
        S_NightRepairProducts  +     0.07865319045115 * S_REP_Age
          +     0.12699700958242 * S_REP_LoyaltyTime
          +     0.26288323756835 * S_TimeSinceLastPurchase
          +      0.0624147907547 * S_TotalSpend ;
   H129  =    -0.20878785078429 * S_AffluenceGrade  +     0.27001744225976 * 
        S_CleanserProducts  +     0.03295443006101 * S_DayCareProducts
          +    -0.28599242695686 * S_LotionProducts  +     0.60077226310539 * 
        S_NightRepairProducts  +    -0.04185162164151 * S_REP_Age
          +    -0.21032696096325 * S_REP_LoyaltyTime
          +    -0.11156176196989 * S_TimeSinceLastPurchase
          +    -0.21879349639934 * S_TotalSpend ;
   H130  =      0.0754634962368 * S_AffluenceGrade  +    -0.18781235964957 * 
        S_CleanserProducts  +     0.38604854978278 * S_DayCareProducts
          +    -0.22076591351157 * S_LotionProducts  +     0.06600352966817 * 
        S_NightRepairProducts  +    -0.01384121453723 * S_REP_Age
          +    -0.14472134997526 * S_REP_LoyaltyTime
          +    -0.32407696133807 * S_TimeSinceLastPurchase
          +    -0.19667357085444 * S_TotalSpend ;
   H131  =     0.03698121660115 * S_AffluenceGrade  +    -0.21218647085859 * 
        S_CleanserProducts  +     0.15815967331875 * S_DayCareProducts
          +    -0.35334107161165 * S_LotionProducts  +     0.00747020215024 * 
        S_NightRepairProducts  +     0.00514670929989 * S_REP_Age
          +     0.18129046425579 * S_REP_LoyaltyTime
          +    -0.01829523690352 * S_TimeSinceLastPurchase
          +     0.05921632532207 * S_TotalSpend ;
   H132  =     0.01575757315687 * S_AffluenceGrade  +     0.04251867334859 * 
        S_CleanserProducts  +     -0.0457947008439 * S_DayCareProducts
          +      0.1951352509367 * S_LotionProducts  +     0.11294110495415 * 
        S_NightRepairProducts  +     0.06345362031265 * S_REP_Age
          +    -0.07885259320187 * S_REP_LoyaltyTime
          +     0.01655891180086 * S_TimeSinceLastPurchase
          +      0.0283585138403 * S_TotalSpend ;
   H101  = H101  +    -0.09354995328333 * CampaignViewedEmail0
          +     0.11606785242982 * MobileApplications0
          +    -0.08983444089799 * PreviousCampaign0 ;
   H102  = H102  +    -0.02956986756157 * CampaignViewedEmail0
          +     0.03062531913131 * MobileApplications0
          +     0.05488309981616 * PreviousCampaign0 ;
   H103  = H103  +      0.2199235352225 * CampaignViewedEmail0
          +    -0.19552112836027 * MobileApplications0
          +    -0.06168780783095 * PreviousCampaign0 ;
   H104  = H104  +     0.18396036147097 * CampaignViewedEmail0
          +     0.12531217146938 * MobileApplications0
          +    -0.05630995761797 * PreviousCampaign0 ;
   H105  = H105  +      0.0220842386115 * CampaignViewedEmail0
          +     0.13613610329487 * MobileApplications0
          +    -0.09138018736421 * PreviousCampaign0 ;
   H106  = H106  +    -0.11119474191107 * CampaignViewedEmail0
          +     0.17686165401969 * MobileApplications0
          +     0.06536229385886 * PreviousCampaign0 ;
   H107  = H107  +     0.28638291133725 * CampaignViewedEmail0
          +     0.19893773374534 * MobileApplications0
          +    -0.04021027767692 * PreviousCampaign0 ;
   H108  = H108  +    -0.06303470797806 * CampaignViewedEmail0
          +     0.18400946833398 * MobileApplications0
          +     0.11990969905642 * PreviousCampaign0 ;
   H109  = H109  +     0.04655098464932 * CampaignViewedEmail0
          +    -0.54143039775478 * MobileApplications0
          +     0.63608778009832 * PreviousCampaign0 ;
   H110  = H110  +    -0.02899466861763 * CampaignViewedEmail0
          +     0.13545152548472 * MobileApplications0
          +    -0.21424307177474 * PreviousCampaign0 ;
   H111  = H111  +    -0.05224919302394 * CampaignViewedEmail0
          +    -0.09377527503757 * MobileApplications0
          +    -0.03054149470199 * PreviousCampaign0 ;
   H112  = H112  +    -0.14620663295324 * CampaignViewedEmail0
          +       0.178283892709 * MobileApplications0
          +     0.07692566387557 * PreviousCampaign0 ;
   H113  = H113  +    -0.03467196131719 * CampaignViewedEmail0
          +      0.0735064854232 * MobileApplications0
          +     0.21056658196826 * PreviousCampaign0 ;
   H114  = H114  +    -0.15126013900758 * CampaignViewedEmail0
          +     0.15996108265056 * MobileApplications0
          +    -0.19602442608237 * PreviousCampaign0 ;
   H115  = H115  +     0.11315585101212 * CampaignViewedEmail0
          +     0.38305305250528 * MobileApplications0
          +    -0.03027402797445 * PreviousCampaign0 ;
   H116  = H116  +     0.11862020182699 * CampaignViewedEmail0
          +    -0.09268865910291 * MobileApplications0
          +    -0.22663793101449 * PreviousCampaign0 ;
   H117  = H117  +    -0.15306657996341 * CampaignViewedEmail0
          +    -0.32008124766347 * MobileApplications0
          +      0.1604969809795 * PreviousCampaign0 ;
   H118  = H118  +    -0.13839958427246 * CampaignViewedEmail0
          +    -0.24445288496712 * MobileApplications0
          +    -0.01807662118606 * PreviousCampaign0 ;
   H119  = H119  +      0.0120911373971 * CampaignViewedEmail0
          +    -0.22028139408454 * MobileApplications0
          +     -0.0286617871978 * PreviousCampaign0 ;
   H120  = H120  +    -0.04625056050749 * CampaignViewedEmail0
          +    -0.05271111344375 * MobileApplications0
          +    -0.00470467571881 * PreviousCampaign0 ;
   H121  = H121  +     0.35800034339995 * CampaignViewedEmail0
          +     0.08028916420918 * MobileApplications0
          +    -0.24557404580534 * PreviousCampaign0 ;
   H122  = H122  +    -0.05641844717658 * CampaignViewedEmail0
          +     0.22862038557349 * MobileApplications0
          +     0.05978461652939 * PreviousCampaign0 ;
   H123  = H123  +    -0.06749259907034 * CampaignViewedEmail0
          +     -0.2258230598633 * MobileApplications0
          +    -0.00421296970255 * PreviousCampaign0 ;
   H124  = H124  +     0.26715864198706 * CampaignViewedEmail0
          +    -0.02619651285968 * MobileApplications0
          +     0.05266008687297 * PreviousCampaign0 ;
   H125  = H125  +     0.11275598526188 * CampaignViewedEmail0
          +    -0.21989299281109 * MobileApplications0
          +     0.22431128655753 * PreviousCampaign0 ;
   H126  = H126  +    -0.13802570601931 * CampaignViewedEmail0
          +    -0.03940539756006 * MobileApplications0
          +    -0.05321720828254 * PreviousCampaign0 ;
   H127  = H127  +    -0.02728616087396 * CampaignViewedEmail0
          +     0.35090396778744 * MobileApplications0
          +     0.16175176615837 * PreviousCampaign0 ;
   H128  = H128  +    -0.11826275706285 * CampaignViewedEmail0
          +    -0.03493440030903 * MobileApplications0
          +     0.06341010357364 * PreviousCampaign0 ;
   H129  = H129  +    -0.08521996966354 * CampaignViewedEmail0
          +    -0.12659273122911 * MobileApplications0
          +     0.18347562178736 * PreviousCampaign0 ;
   H130  = H130  +     0.29935678353708 * CampaignViewedEmail0
          +    -0.10404047238752 * MobileApplications0
          +    -0.28868980482564 * PreviousCampaign0 ;
   H131  = H131  +     0.06554234834221 * CampaignViewedEmail0
          +    -0.19413344376056 * MobileApplications0
          +     0.24338385127878 * PreviousCampaign0 ;
   H132  = H132  +    -0.03626196804754 * CampaignViewedEmail0
          +    -0.07935292333039 * MobileApplications0
          +    -0.03973206679904 * PreviousCampaign0 ;
   H101  = H101  +     0.10305423880715 * LoyaltyClassGold
          +     0.07018279283727 * REP_AdvertisementZonBorder
          +     0.15809947828789 * REP_AdvertisementZonCentral_Z1
          +    -0.13262706520745 * REP_AdvertisementZonE_Central
          +    -0.29718039671208 * REP_AdvertisementZonN_Central
          +    -0.06705576149736 * REP_AdvertisementZonN_East
          +     0.10174716928337 * REP_AdvertisementZonN_West
          +    -0.20695053548701 * REP_AdvertisementZonNE_Z1
          +    -0.28928393022852 * REP_AdvertisementZonNE_Z2
          +    -0.03592895254246 * REP_AdvertisementZonNE_Z3
          +    -0.02749080219343 * REP_AdvertisementZonS_Central
          +     0.02887365441263 * REP_AdvertisementZonS_East
          +     0.09166441733236 * REP_AdvertisementZonS_West
          +     0.04359275922841 * REP_AdvertisementZonU
          +     0.18368450266971 * REP_ClusterGroupA
          +    -0.24541592835702 * REP_ClusterGroupB
          +     0.04977851963155 * REP_ClusterGroupC
          +      0.0818357025465 * REP_ClusterGroupD
          +     0.30711271755133 * REP_ClusterGroupE
          +     0.12443619832167 * REP_ClusterGroupF
          +     0.04170973082324 * REP_GenderF  +     0.11603152030702 * 
        REP_RegionCentral  +    -0.16793317582161 * REP_RegionNorth
          +     0.09037203395983 * REP_RegionNorthEast
          +    -0.39273128799611 * REP_RegionSouth_East
          +     0.21546762808394 * REP_RegionSouth_West ;
   H102  = H102  +    -0.06350350023411 * LoyaltyClassGold
          +     0.15772959147058 * REP_AdvertisementZonBorder
          +     0.01771518110525 * REP_AdvertisementZonCentral_Z1
          +    -0.19841318487094 * REP_AdvertisementZonE_Central
          +      0.0287363750786 * REP_AdvertisementZonN_Central
          +     0.02575337831753 * REP_AdvertisementZonN_East
          +    -0.08723481712292 * REP_AdvertisementZonN_West
          +    -0.16945497529326 * REP_AdvertisementZonNE_Z1
          +     0.03322652477565 * REP_AdvertisementZonNE_Z2
          +    -0.19677110907332 * REP_AdvertisementZonNE_Z3
          +     0.36713122190943 * REP_AdvertisementZonS_Central
          +    -0.36728596616281 * REP_AdvertisementZonS_East
          +    -0.19587829541154 * REP_AdvertisementZonS_West
          +     0.27475432289817 * REP_AdvertisementZonU
          +     0.01274973486469 * REP_ClusterGroupA
          +     0.16132516412555 * REP_ClusterGroupB
          +    -0.23779863552322 * REP_ClusterGroupC
          +     -0.0163710930836 * REP_ClusterGroupD
          +    -0.12130555560402 * REP_ClusterGroupE
          +    -0.24954005556626 * REP_ClusterGroupF
          +     0.09381231303725 * REP_GenderF  +    -0.30340278492446 * 
        REP_RegionCentral  +     0.00562605145058 * REP_RegionNorth
          +    -0.06760396058242 * REP_RegionNorthEast
          +     0.08567631552754 * REP_RegionSouth_East
          +    -0.07807300470802 * REP_RegionSouth_West ;
   H103  = H103  +     0.19988536571313 * LoyaltyClassGold
          +     -0.1774117330525 * REP_AdvertisementZonBorder
          +     0.04313305523594 * REP_AdvertisementZonCentral_Z1
          +     0.16528437540851 * REP_AdvertisementZonE_Central
          +    -0.04700235702377 * REP_AdvertisementZonN_Central
          +    -0.07602367405149 * REP_AdvertisementZonN_East
          +      0.0483075256136 * REP_AdvertisementZonN_West
          +    -0.05304614307202 * REP_AdvertisementZonNE_Z1
          +     0.04249355498839 * REP_AdvertisementZonNE_Z2
          +    -0.00188037436687 * REP_AdvertisementZonNE_Z3
          +    -0.10096083156902 * REP_AdvertisementZonS_Central
          +    -0.10895024290677 * REP_AdvertisementZonS_East
          +    -0.08727648456029 * REP_AdvertisementZonS_West
          +      0.0179849620964 * REP_AdvertisementZonU
          +    -0.00318586012076 * REP_ClusterGroupA
          +    -0.06792772526996 * REP_ClusterGroupB
          +     0.02064976910858 * REP_ClusterGroupC
          +     0.11940770663747 * REP_ClusterGroupD
          +     0.09962984951918 * REP_ClusterGroupE
          +     0.24841452247915 * REP_ClusterGroupF
          +     0.05446563170171 * REP_GenderF  +     0.00254123906269 * 
        REP_RegionCentral  +    -0.04985916069275 * REP_RegionNorth
          +     0.03525510468663 * REP_RegionNorthEast
          +     0.14455468169011 * REP_RegionSouth_East
          +    -0.14071528012818 * REP_RegionSouth_West ;
   H104  = H104  +     0.00452087007321 * LoyaltyClassGold
          +    -0.27994265150082 * REP_AdvertisementZonBorder
          +     0.05148412012682 * REP_AdvertisementZonCentral_Z1
          +     0.22013410501063 * REP_AdvertisementZonE_Central
          +     -0.0507490968996 * REP_AdvertisementZonN_Central
          +    -0.05184468683466 * REP_AdvertisementZonN_East
          +    -0.27097912978644 * REP_AdvertisementZonN_West
          +    -0.05271099804836 * REP_AdvertisementZonNE_Z1
          +    -0.02577124139062 * REP_AdvertisementZonNE_Z2
          +     0.21998590605943 * REP_AdvertisementZonNE_Z3
          +     0.06455654714562 * REP_AdvertisementZonS_Central
          +    -0.33201389898219 * REP_AdvertisementZonS_East
          +      -0.295404702167 * REP_AdvertisementZonS_West
          +     0.04915705100974 * REP_AdvertisementZonU
          +    -0.06131999459979 * REP_ClusterGroupA
          +     0.11037146025534 * REP_ClusterGroupB
          +     0.00712027651291 * REP_ClusterGroupC
          +    -0.05916932167113 * REP_ClusterGroupD
          +     0.19182066521507 * REP_ClusterGroupE
          +     0.36546497039026 * REP_ClusterGroupF
          +    -0.00784563683381 * REP_GenderF  +    -0.44340071064012 * 
        REP_RegionCentral  +     0.05862405276025 * REP_RegionNorth
          +     0.16187871641628 * REP_RegionNorthEast
          +     0.13506583419482 * REP_RegionSouth_East
          +     -0.1408282996419 * REP_RegionSouth_West ;
   H105  = H105  +     0.12893102561998 * LoyaltyClassGold
          +     0.01270239026562 * REP_AdvertisementZonBorder
          +    -0.23499317552378 * REP_AdvertisementZonCentral_Z1
          +     0.00227052104159 * REP_AdvertisementZonE_Central
          +    -0.31620052636444 * REP_AdvertisementZonN_Central
          +     0.20756023203124 * REP_AdvertisementZonN_East
          +    -0.14463940971745 * REP_AdvertisementZonN_West
          +     0.05063492212432 * REP_AdvertisementZonNE_Z1
          +    -0.08579482508865 * REP_AdvertisementZonNE_Z2
          +     0.30030475838301 * REP_AdvertisementZonNE_Z3
          +     0.21777491770129 * REP_AdvertisementZonS_Central
          +     0.08961800463549 * REP_AdvertisementZonS_East
          +    -0.15841508891465 * REP_AdvertisementZonS_West
          +    -0.18996958839464 * REP_AdvertisementZonU
          +     0.08846771850874 * REP_ClusterGroupA
          +     0.18196771634289 * REP_ClusterGroupB
          +     0.10586729005429 * REP_ClusterGroupC
          +    -0.19192436313528 * REP_ClusterGroupD
          +     0.02592846588799 * REP_ClusterGroupE
          +     0.25811096696814 * REP_ClusterGroupF
          +     0.15166276564882 * REP_GenderF  +    -0.32469126870641 * 
        REP_RegionCentral  +    -0.07570470829809 * REP_RegionNorth
          +    -0.19453274825113 * REP_RegionNorthEast
          +    -0.27193693930528 * REP_RegionSouth_East
          +    -0.03208528463645 * REP_RegionSouth_West ;
   H106  = H106  +     0.06494322230978 * LoyaltyClassGold
          +      -0.164007848468 * REP_AdvertisementZonBorder
          +     0.17454380183689 * REP_AdvertisementZonCentral_Z1
          +     0.02340778625544 * REP_AdvertisementZonE_Central
          +    -0.19654658530962 * REP_AdvertisementZonN_Central
          +     0.13324883390103 * REP_AdvertisementZonN_East
          +     0.39949308353909 * REP_AdvertisementZonN_West
          +    -0.11330792336255 * REP_AdvertisementZonNE_Z1
          +    -0.35768782441425 * REP_AdvertisementZonNE_Z2
          +     -0.1334869294475 * REP_AdvertisementZonNE_Z3
          +    -0.01476536181863 * REP_AdvertisementZonS_Central
          +     0.00354431142624 * REP_AdvertisementZonS_East
          +     0.04733990341094 * REP_AdvertisementZonS_West
          +    -0.10632058895789 * REP_AdvertisementZonU
          +     0.09849572538095 * REP_ClusterGroupA
          +     0.17735187616451 * REP_ClusterGroupB
          +    -0.01522704920733 * REP_ClusterGroupC
          +    -0.06492864017619 * REP_ClusterGroupD
          +    -0.07315606070655 * REP_ClusterGroupE
          +    -0.16055926638574 * REP_ClusterGroupF
          +     0.12236213100654 * REP_GenderF  +     0.06322861387406 * 
        REP_RegionCentral  +     0.28005546437702 * REP_RegionNorth
          +    -0.02704494656166 * REP_RegionNorthEast
          +    -0.03614695340704 * REP_RegionSouth_East
          +     0.38958383992459 * REP_RegionSouth_West ;
   H107  = H107  +     0.37780386458059 * LoyaltyClassGold
          +     0.28249421116247 * REP_AdvertisementZonBorder
          +     0.07068687276198 * REP_AdvertisementZonCentral_Z1
          +    -0.27360937281324 * REP_AdvertisementZonE_Central
          +    -0.08783016847237 * REP_AdvertisementZonN_Central
          +    -0.06913398703088 * REP_AdvertisementZonN_East
          +     0.22477249050221 * REP_AdvertisementZonN_West
          +     -0.1716194379177 * REP_AdvertisementZonNE_Z1
          +    -0.01855390375437 * REP_AdvertisementZonNE_Z2
          +     0.00063986874257 * REP_AdvertisementZonNE_Z3
          +     0.21639512318096 * REP_AdvertisementZonS_Central
          +     0.05574704866304 * REP_AdvertisementZonS_East
          +    -0.17420307923569 * REP_AdvertisementZonS_West
          +    -0.05662041531792 * REP_AdvertisementZonU
          +    -0.06507428349528 * REP_ClusterGroupA
          +     0.19452245585466 * REP_ClusterGroupB
          +     0.12860116125289 * REP_ClusterGroupC
          +     -0.0446018479201 * REP_ClusterGroupD
          +    -0.20585411953999 * REP_ClusterGroupE
          +    -0.13327575698518 * REP_ClusterGroupF
          +    -0.05319788885573 * REP_GenderF  +     0.34981936890044 * 
        REP_RegionCentral  +     0.11294839161607 * REP_RegionNorth
          +     0.17527897367996 * REP_RegionNorthEast
          +    -0.15895162954027 * REP_RegionSouth_East
          +     0.10362651093355 * REP_RegionSouth_West ;
   H108  = H108  +    -0.00681914380912 * LoyaltyClassGold
          +     0.06339875721143 * REP_AdvertisementZonBorder
          +     0.26822722869446 * REP_AdvertisementZonCentral_Z1
          +    -0.01030798710672 * REP_AdvertisementZonE_Central
          +    -0.36235459765448 * REP_AdvertisementZonN_Central
          +    -0.25550544250513 * REP_AdvertisementZonN_East
          +    -0.04214949333623 * REP_AdvertisementZonN_West
          +    -0.04623855874568 * REP_AdvertisementZonNE_Z1
          +    -0.03312558666962 * REP_AdvertisementZonNE_Z2
          +    -0.00529789308978 * REP_AdvertisementZonNE_Z3
          +     0.48266593108627 * REP_AdvertisementZonS_Central
          +     0.10180932629603 * REP_AdvertisementZonS_East
          +    -0.26106258157897 * REP_AdvertisementZonS_West
          +    -0.02191672054995 * REP_AdvertisementZonU
          +    -0.27520954052445 * REP_ClusterGroupA
          +    -0.08058440732991 * REP_ClusterGroupB
          +    -0.03187691847231 * REP_ClusterGroupC
          +    -0.17977970020988 * REP_ClusterGroupD
          +    -0.18168585659372 * REP_ClusterGroupE
          +     0.22992917074373 * REP_ClusterGroupF
          +     0.06599468089637 * REP_GenderF  +    -0.20228213331588 * 
        REP_RegionCentral  +     0.04772009592678 * REP_RegionNorth
          +    -0.05423049349791 * REP_RegionNorthEast
          +    -0.16075632700935 * REP_RegionSouth_East
          +    -0.16081383435815 * REP_RegionSouth_West ;
   H109  = H109  +    -0.02292799825096 * LoyaltyClassGold
          +    -0.11225784139484 * REP_AdvertisementZonBorder
          +    -0.05601515354257 * REP_AdvertisementZonCentral_Z1
          +    -0.10545104658079 * REP_AdvertisementZonE_Central
          +     0.34399457638646 * REP_AdvertisementZonN_Central
          +       0.059066920245 * REP_AdvertisementZonN_East
          +     0.00060620246638 * REP_AdvertisementZonN_West
          +     0.14965808238414 * REP_AdvertisementZonNE_Z1
          +     0.16749595522977 * REP_AdvertisementZonNE_Z2
          +    -0.10220186828896 * REP_AdvertisementZonNE_Z3
          +     0.01678096079353 * REP_AdvertisementZonS_Central
          +     0.00222714640671 * REP_AdvertisementZonS_East
          +      0.0712367262452 * REP_AdvertisementZonS_West
          +    -0.02131536238506 * REP_AdvertisementZonU
          +    -0.03909060277223 * REP_ClusterGroupA
          +     0.10416831930404 * REP_ClusterGroupB
          +    -0.03495678174112 * REP_ClusterGroupC
          +     0.11151760944055 * REP_ClusterGroupD
          +    -0.01358404289335 * REP_ClusterGroupE
          +    -0.26813206711723 * REP_ClusterGroupF
          +    -0.31615050491271 * REP_GenderF  +    -0.16328642001776 * 
        REP_RegionCentral  +     0.10787250110411 * REP_RegionNorth
          +     0.03513443272046 * REP_RegionNorthEast
          +      -0.132471085676 * REP_RegionSouth_East
          +    -0.18874549161565 * REP_RegionSouth_West ;
   H110  = H110  +     0.26582119939462 * LoyaltyClassGold
          +     0.12142719135198 * REP_AdvertisementZonBorder
          +    -0.29098135072623 * REP_AdvertisementZonCentral_Z1
          +    -0.08396553424558 * REP_AdvertisementZonE_Central
          +    -0.01960887834104 * REP_AdvertisementZonN_Central
          +     0.04299857563738 * REP_AdvertisementZonN_East
          +     0.23018197798692 * REP_AdvertisementZonN_West
          +    -0.02595035549271 * REP_AdvertisementZonNE_Z1
          +     0.04710097370515 * REP_AdvertisementZonNE_Z2
          +    -0.08632559336788 * REP_AdvertisementZonNE_Z3
          +    -0.08805307286629 * REP_AdvertisementZonS_Central
          +     0.15687213784222 * REP_AdvertisementZonS_East
          +    -0.20429879014105 * REP_AdvertisementZonS_West
          +     0.04028742206771 * REP_AdvertisementZonU
          +    -0.00700827151748 * REP_ClusterGroupA
          +    -0.00887683809858 * REP_ClusterGroupB
          +    -0.13081754318021 * REP_ClusterGroupC
          +      -0.010945463903 * REP_ClusterGroupD
          +    -0.16052346615008 * REP_ClusterGroupE
          +     0.09188304048483 * REP_ClusterGroupF
          +    -0.28264047287995 * REP_GenderF  +     0.07981950711059 * 
        REP_RegionCentral  +    -0.03830246571522 * REP_RegionNorth
          +    -0.19676766550704 * REP_RegionNorthEast
          +    -0.06386356996408 * REP_RegionSouth_East
          +     0.02444219559902 * REP_RegionSouth_West ;
   H111  = H111  +    -0.23875764767801 * LoyaltyClassGold
          +     0.11558790405355 * REP_AdvertisementZonBorder
          +     0.00147681687038 * REP_AdvertisementZonCentral_Z1
          +     0.28864226374385 * REP_AdvertisementZonE_Central
          +     0.15113366314394 * REP_AdvertisementZonN_Central
          +    -0.26107021330999 * REP_AdvertisementZonN_East
          +     0.00166374624171 * REP_AdvertisementZonN_West
          +     0.06650601340048 * REP_AdvertisementZonNE_Z1
          +     -0.1003464839102 * REP_AdvertisementZonNE_Z2
          +     0.02965329531354 * REP_AdvertisementZonNE_Z3
          +    -0.10144749245175 * REP_AdvertisementZonS_Central
          +    -0.04643312532981 * REP_AdvertisementZonS_East
          +     0.20816678328865 * REP_AdvertisementZonS_West
          +     0.50834434431428 * REP_AdvertisementZonU
          +     0.01226926533574 * REP_ClusterGroupA
          +    -0.11762511715776 * REP_ClusterGroupB
          +     0.21279332599127 * REP_ClusterGroupC
          +      -0.194423041249 * REP_ClusterGroupD
          +    -0.20352674722381 * REP_ClusterGroupE
          +    -0.19347909896517 * REP_ClusterGroupF
          +     0.13188287832557 * REP_GenderF  +     0.08694637276854 * 
        REP_RegionCentral  +     0.25239350787874 * REP_RegionNorth
          +    -0.39077756901339 * REP_RegionNorthEast
          +    -0.01021395194689 * REP_RegionSouth_East
          +     0.01410154739706 * REP_RegionSouth_West ;
   H112  = H112  +    -0.05288712504347 * LoyaltyClassGold
          +    -0.02479036992664 * REP_AdvertisementZonBorder
          +    -0.01084017418644 * REP_AdvertisementZonCentral_Z1
          +    -0.19644599963372 * REP_AdvertisementZonE_Central
          +    -0.02345718452985 * REP_AdvertisementZonN_Central
          +    -0.15407599883588 * REP_AdvertisementZonN_East
          +    -0.13451101579364 * REP_AdvertisementZonN_West
          +     0.02078790427231 * REP_AdvertisementZonNE_Z1
          +    -0.39631442237579 * REP_AdvertisementZonNE_Z2
          +    -0.15299401374231 * REP_AdvertisementZonNE_Z3
          +     0.20968563556568 * REP_AdvertisementZonS_Central
          +    -0.04357698275168 * REP_AdvertisementZonS_East
          +    -0.10845749018879 * REP_AdvertisementZonS_West
          +    -0.13184945880608 * REP_AdvertisementZonU
          +     0.04801114615329 * REP_ClusterGroupA
          +     0.01463956927231 * REP_ClusterGroupB
          +     0.37645280610998 * REP_ClusterGroupC
          +    -0.06800246724326 * REP_ClusterGroupD
          +     0.12864988802888 * REP_ClusterGroupE
          +    -0.10214497454912 * REP_ClusterGroupF
          +    -0.04358077541338 * REP_GenderF  +     0.11090597629172 * 
        REP_RegionCentral  +    -0.26554339625168 * REP_RegionNorth
          +    -0.09305405606535 * REP_RegionNorthEast
          +     0.28645236727953 * REP_RegionSouth_East
          +    -0.06047509453481 * REP_RegionSouth_West ;
   H113  = H113  +    -0.08870818305569 * LoyaltyClassGold
          +    -0.39237607817594 * REP_AdvertisementZonBorder
          +    -0.04729057895001 * REP_AdvertisementZonCentral_Z1
          +     0.02937945406717 * REP_AdvertisementZonE_Central
          +    -0.10306013046994 * REP_AdvertisementZonN_Central
          +     0.28195338640035 * REP_AdvertisementZonN_East
          +    -0.24334276693419 * REP_AdvertisementZonN_West
          +     0.22720499762935 * REP_AdvertisementZonNE_Z1
          +     0.15727822597049 * REP_AdvertisementZonNE_Z2
          +    -0.10153836624129 * REP_AdvertisementZonNE_Z3
          +    -0.12408581732639 * REP_AdvertisementZonS_Central
          +     0.07562835581426 * REP_AdvertisementZonS_East
          +    -0.14859031075562 * REP_AdvertisementZonS_West
          +     -0.1501081854371 * REP_AdvertisementZonU
          +      0.1077365519115 * REP_ClusterGroupA
          +    -0.05640759314915 * REP_ClusterGroupB
          +    -0.26963495195425 * REP_ClusterGroupC
          +     0.21800707326815 * REP_ClusterGroupD
          +    -0.16620362815072 * REP_ClusterGroupE
          +     0.28631935704697 * REP_ClusterGroupF
          +      0.0310186104196 * REP_GenderF  +     0.11558722636824 * 
        REP_RegionCentral  +      0.0381661489867 * REP_RegionNorth
          +    -0.07062288621122 * REP_RegionNorthEast
          +     0.11059771389924 * REP_RegionSouth_East
          +     0.21136718923587 * REP_RegionSouth_West ;
   H114  = H114  +     0.21842096040696 * LoyaltyClassGold
          +    -0.18144123390993 * REP_AdvertisementZonBorder
          +     0.11704388805164 * REP_AdvertisementZonCentral_Z1
          +    -0.31031625590581 * REP_AdvertisementZonE_Central
          +    -0.01898068346353 * REP_AdvertisementZonN_Central
          +    -0.16917426135114 * REP_AdvertisementZonN_East
          +     0.14501259637498 * REP_AdvertisementZonN_West
          +    -0.09882995627255 * REP_AdvertisementZonNE_Z1
          +    -0.10997718223752 * REP_AdvertisementZonNE_Z2
          +    -0.04762620063042 * REP_AdvertisementZonNE_Z3
          +    -0.04415934701805 * REP_AdvertisementZonS_Central
          +    -0.00305238409406 * REP_AdvertisementZonS_East
          +    -0.08819516868814 * REP_AdvertisementZonS_West
          +    -0.03287210640919 * REP_AdvertisementZonU
          +    -0.04249222800543 * REP_ClusterGroupA
          +      0.1688786152711 * REP_ClusterGroupB
          +    -0.17013822530964 * REP_ClusterGroupC
          +     0.04811008439946 * REP_ClusterGroupD
          +     0.15514897247765 * REP_ClusterGroupE
          +     -0.4061243283946 * REP_ClusterGroupF
          +     0.06362116420708 * REP_GenderF  +     0.22904988320749 * 
        REP_RegionCentral  +     0.28820810829897 * REP_RegionNorth
          +    -0.08572157024293 * REP_RegionNorthEast
          +    -0.22820135255376 * REP_RegionSouth_East
          +     0.01197644098346 * REP_RegionSouth_West ;
   H115  = H115  +     0.12003305475798 * LoyaltyClassGold
          +    -0.13155755972831 * REP_AdvertisementZonBorder
          +     0.11193769289124 * REP_AdvertisementZonCentral_Z1
          +    -0.12536644850345 * REP_AdvertisementZonE_Central
          +     0.23226283471699 * REP_AdvertisementZonN_Central
          +    -0.11674942967763 * REP_AdvertisementZonN_East
          +      0.1125664019297 * REP_AdvertisementZonN_West
          +     0.09782393207698 * REP_AdvertisementZonNE_Z1
          +    -0.26493433593392 * REP_AdvertisementZonNE_Z2
          +    -0.09854569937726 * REP_AdvertisementZonNE_Z3
          +     0.16835227280878 * REP_AdvertisementZonS_Central
          +    -0.06489717063467 * REP_AdvertisementZonS_East
          +     0.01127308487842 * REP_AdvertisementZonS_West
          +    -0.31090495277588 * REP_AdvertisementZonU
          +    -0.29081755941359 * REP_ClusterGroupA
          +    -0.14998082364331 * REP_ClusterGroupB
          +    -0.07829355675663 * REP_ClusterGroupC
          +     0.04701555851215 * REP_ClusterGroupD
          +    -0.00163394546941 * REP_ClusterGroupE
          +    -0.46103227719537 * REP_ClusterGroupF
          +     -0.0157750353164 * REP_GenderF  +     0.18442304684127 * 
        REP_RegionCentral  +     -0.0623891030849 * REP_RegionNorth
          +    -0.11181134365527 * REP_RegionNorthEast
          +     0.05534450397543 * REP_RegionSouth_East
          +     0.05669025270671 * REP_RegionSouth_West ;
   H116  = H116  +     -0.1367503403983 * LoyaltyClassGold
          +     0.39676714040411 * REP_AdvertisementZonBorder
          +      0.1059106502912 * REP_AdvertisementZonCentral_Z1
          +      0.1306175311658 * REP_AdvertisementZonE_Central
          +     0.12289955595569 * REP_AdvertisementZonN_Central
          +     0.01862261236804 * REP_AdvertisementZonN_East
          +    -0.09366575763626 * REP_AdvertisementZonN_West
          +     0.04466722930023 * REP_AdvertisementZonNE_Z1
          +     0.20271907976837 * REP_AdvertisementZonNE_Z2
          +     0.26966927282592 * REP_AdvertisementZonNE_Z3
          +     0.08784741268116 * REP_AdvertisementZonS_Central
          +     0.11261529752853 * REP_AdvertisementZonS_East
          +     0.34455270500623 * REP_AdvertisementZonS_West
          +     0.04657576462278 * REP_AdvertisementZonU
          +     0.15947999908982 * REP_ClusterGroupA
          +     0.06088673227086 * REP_ClusterGroupB
          +       0.030769618193 * REP_ClusterGroupC
          +    -0.07242167572664 * REP_ClusterGroupD
          +     0.19125641266037 * REP_ClusterGroupE
          +      0.0786245719444 * REP_ClusterGroupF
          +    -0.04928662799298 * REP_GenderF  +     0.01060214123856 * 
        REP_RegionCentral  +     0.10240101164135 * REP_RegionNorth
          +    -0.23989470413458 * REP_RegionNorthEast
          +     0.37674639311065 * REP_RegionSouth_East
          +    -0.26194150193782 * REP_RegionSouth_West ;
   H117  = H117  +     0.17164661602633 * LoyaltyClassGold
          +     0.19798510835868 * REP_AdvertisementZonBorder
          +       0.020276328689 * REP_AdvertisementZonCentral_Z1
          +    -0.32233574726586 * REP_AdvertisementZonE_Central
          +       0.096249272856 * REP_AdvertisementZonN_Central
          +     0.18190337958233 * REP_AdvertisementZonN_East
          +     0.13905708094571 * REP_AdvertisementZonN_West
          +    -0.37407508196918 * REP_AdvertisementZonNE_Z1
          +     0.13056638514484 * REP_AdvertisementZonNE_Z2
          +    -0.04331151984576 * REP_AdvertisementZonNE_Z3
          +      0.4932042005488 * REP_AdvertisementZonS_Central
          +     0.06069607484759 * REP_AdvertisementZonS_East
          +    -0.06768609561704 * REP_AdvertisementZonS_West
          +    -0.01199948656322 * REP_AdvertisementZonU
          +    -0.08221169803078 * REP_ClusterGroupA
          +     0.11716845710179 * REP_ClusterGroupB
          +    -0.11860421198633 * REP_ClusterGroupC
          +     0.04291470585823 * REP_ClusterGroupD
          +      -0.127362573243 * REP_ClusterGroupE
          +    -0.29636412944922 * REP_ClusterGroupF
          +     0.03080547485689 * REP_GenderF  +     0.04964070967457 * 
        REP_RegionCentral  +    -0.25443652795969 * REP_RegionNorth
          +     0.05852437379473 * REP_RegionNorthEast
          +    -0.14851949584766 * REP_RegionSouth_East
          +     -0.2060430399573 * REP_RegionSouth_West ;
   H118  = H118  +    -0.41824794902529 * LoyaltyClassGold
          +     0.13326737851292 * REP_AdvertisementZonBorder
          +     0.30363245180841 * REP_AdvertisementZonCentral_Z1
          +     0.05769611081125 * REP_AdvertisementZonE_Central
          +    -0.17018969198778 * REP_AdvertisementZonN_Central
          +     0.10383888597908 * REP_AdvertisementZonN_East
          +    -0.07166911867822 * REP_AdvertisementZonN_West
          +     0.11980633734394 * REP_AdvertisementZonNE_Z1
          +     0.11151255914824 * REP_AdvertisementZonNE_Z2
          +     -0.1786981802596 * REP_AdvertisementZonNE_Z3
          +     0.04525148230427 * REP_AdvertisementZonS_Central
          +     0.06677977746457 * REP_AdvertisementZonS_East
          +     0.14530440501033 * REP_AdvertisementZonS_West
          +     0.07441454288788 * REP_AdvertisementZonU
          +     0.06591734553845 * REP_ClusterGroupA
          +    -0.03110008506922 * REP_ClusterGroupB
          +    -0.09678980518328 * REP_ClusterGroupC
          +     0.09752772092942 * REP_ClusterGroupD
          +     0.21646390680721 * REP_ClusterGroupE
          +     0.13440060503153 * REP_ClusterGroupF
          +    -0.08603576749931 * REP_GenderF  +    -0.25366235710308 * 
        REP_RegionCentral  +     0.09484726118075 * REP_RegionNorth
          +    -0.05820835439038 * REP_RegionNorthEast
          +     0.15965670845151 * REP_RegionSouth_East
          +     0.18775061913684 * REP_RegionSouth_West ;
   H119  = H119  +    -0.08395245608341 * LoyaltyClassGold
          +    -0.06246578381478 * REP_AdvertisementZonBorder
          +    -0.15205635689563 * REP_AdvertisementZonCentral_Z1
          +    -0.07368498853138 * REP_AdvertisementZonE_Central
          +      0.2779919333312 * REP_AdvertisementZonN_Central
          +    -0.14757449405365 * REP_AdvertisementZonN_East
          +    -0.00777006916065 * REP_AdvertisementZonN_West
          +     0.03701743388609 * REP_AdvertisementZonNE_Z1
          +      0.2653860600749 * REP_AdvertisementZonNE_Z2
          +    -0.07945157478364 * REP_AdvertisementZonNE_Z3
          +     0.17825249951787 * REP_AdvertisementZonS_Central
          +     0.25374795819554 * REP_AdvertisementZonS_East
          +    -0.04605560154514 * REP_AdvertisementZonS_West
          +    -0.08061727758796 * REP_AdvertisementZonU
          +     0.03853806765119 * REP_ClusterGroupA
          +     0.00573785349773 * REP_ClusterGroupB
          +     0.29672746360335 * REP_ClusterGroupC
          +     0.39295469483946 * REP_ClusterGroupD
          +     0.05225513931218 * REP_ClusterGroupE
          +     0.13448706345599 * REP_ClusterGroupF
          +     0.27040395678715 * REP_GenderF  +     0.21418649719064 * 
        REP_RegionCentral  +     0.24097033854811 * REP_RegionNorth
          +     0.13938087778081 * REP_RegionNorthEast
          +     0.01634631100217 * REP_RegionSouth_East
          +    -0.02838366423387 * REP_RegionSouth_West ;
   H120  = H120  +     0.02689142921586 * LoyaltyClassGold
          +     0.28219199813444 * REP_AdvertisementZonBorder
          +    -0.06772497704048 * REP_AdvertisementZonCentral_Z1
          +    -0.01195197424499 * REP_AdvertisementZonE_Central
          +    -0.09102959631299 * REP_AdvertisementZonN_Central
          +     0.21002498941133 * REP_AdvertisementZonN_East
          +     0.18667709958034 * REP_AdvertisementZonN_West
          +       0.031455905063 * REP_AdvertisementZonNE_Z1
          +    -0.24731919176037 * REP_AdvertisementZonNE_Z2
          +     0.02517671195083 * REP_AdvertisementZonNE_Z3
          +     0.04440295844397 * REP_AdvertisementZonS_Central
          +     0.03991814482229 * REP_AdvertisementZonS_East
          +    -0.10066501970469 * REP_AdvertisementZonS_West
          +    -0.01112375911369 * REP_AdvertisementZonU
          +     0.09001538958985 * REP_ClusterGroupA
          +     0.09081451084373 * REP_ClusterGroupB
          +     0.28848764488851 * REP_ClusterGroupC
          +     0.32539650762649 * REP_ClusterGroupD
          +    -0.09884487009136 * REP_ClusterGroupE
          +    -0.00527316930329 * REP_ClusterGroupF
          +      0.1338046616381 * REP_GenderF  +    -0.07110428921568 * 
        REP_RegionCentral  +    -0.00637164005559 * REP_RegionNorth
          +    -0.17433910795682 * REP_RegionNorthEast
          +     0.13266314631716 * REP_RegionSouth_East
          +    -0.10176079168515 * REP_RegionSouth_West ;
   H121  = H121  +     0.23033527818313 * LoyaltyClassGold
          +    -0.07324885123483 * REP_AdvertisementZonBorder
          +     0.05922121592215 * REP_AdvertisementZonCentral_Z1
          +    -0.17744522153348 * REP_AdvertisementZonE_Central
          +    -0.10606343914672 * REP_AdvertisementZonN_Central
          +    -0.02281034348481 * REP_AdvertisementZonN_East
          +    -0.15396295071576 * REP_AdvertisementZonN_West
          +    -0.05772596806615 * REP_AdvertisementZonNE_Z1
          +    -0.08077582407536 * REP_AdvertisementZonNE_Z2
          +    -0.06951089219517 * REP_AdvertisementZonNE_Z3
          +    -0.09590364164203 * REP_AdvertisementZonS_Central
          +    -0.07796146736302 * REP_AdvertisementZonS_East
          +    -0.15450741029132 * REP_AdvertisementZonS_West
          +    -0.10059969843771 * REP_AdvertisementZonU
          +    -0.07315838073069 * REP_ClusterGroupA
          +     0.05062714643596 * REP_ClusterGroupB
          +    -0.25733283860908 * REP_ClusterGroupC
          +    -0.06273589515018 * REP_ClusterGroupD
          +    -0.09440278948868 * REP_ClusterGroupE
          +     0.32370094615685 * REP_ClusterGroupF
          +    -0.01612564020121 * REP_GenderF  +    -0.06347477066762 * 
        REP_RegionCentral  +    -0.07814284769073 * REP_RegionNorth
          +    -0.27669760512296 * REP_RegionNorthEast
          +    -0.04748167757749 * REP_RegionSouth_East
          +     0.01541848287511 * REP_RegionSouth_West ;
   H122  = H122  +     0.04527531379109 * LoyaltyClassGold
          +    -0.08808940077308 * REP_AdvertisementZonBorder
          +    -0.10536834624026 * REP_AdvertisementZonCentral_Z1
          +     0.03862448317397 * REP_AdvertisementZonE_Central
          +    -0.01438647336345 * REP_AdvertisementZonN_Central
          +     0.13707968266385 * REP_AdvertisementZonN_East
          +     0.02467752094094 * REP_AdvertisementZonN_West
          +     0.09721430936983 * REP_AdvertisementZonNE_Z1
          +     0.03894730776444 * REP_AdvertisementZonNE_Z2
          +     0.27099665142563 * REP_AdvertisementZonNE_Z3
          +    -0.11165381112815 * REP_AdvertisementZonS_Central
          +    -0.23005354580695 * REP_AdvertisementZonS_East
          +    -0.12301597549787 * REP_AdvertisementZonS_West
          +      0.0401947280046 * REP_AdvertisementZonU
          +     0.12408435116579 * REP_ClusterGroupA
          +    -0.08336466704319 * REP_ClusterGroupB
          +     0.31896153057863 * REP_ClusterGroupC
          +    -0.19211004249922 * REP_ClusterGroupD
          +    -0.17314635958625 * REP_ClusterGroupE
          +     0.11011466324135 * REP_ClusterGroupF
          +    -0.01974323498953 * REP_GenderF  +    -0.28297437640767 * 
        REP_RegionCentral  +     0.13930820247736 * REP_RegionNorth
          +     0.05816574243735 * REP_RegionNorthEast
          +    -0.02597606521083 * REP_RegionSouth_East
          +     0.24221612493329 * REP_RegionSouth_West ;
   H123  = H123  +    -0.11305303860958 * LoyaltyClassGold
          +     0.20295918785954 * REP_AdvertisementZonBorder
          +     0.15972000136458 * REP_AdvertisementZonCentral_Z1
          +    -0.10943138206682 * REP_AdvertisementZonE_Central
          +     0.26388276423692 * REP_AdvertisementZonN_Central
          +    -0.37780424016339 * REP_AdvertisementZonN_East
          +      0.0958490773155 * REP_AdvertisementZonN_West
          +     0.02815280512018 * REP_AdvertisementZonNE_Z1
          +    -0.19981775487301 * REP_AdvertisementZonNE_Z2
          +    -0.14227407513656 * REP_AdvertisementZonNE_Z3
          +     0.18529312455049 * REP_AdvertisementZonS_Central
          +     0.01634575060065 * REP_AdvertisementZonS_East
          +     0.03323299173012 * REP_AdvertisementZonS_West
          +    -0.30600592831209 * REP_AdvertisementZonU
          +     0.05687008607989 * REP_ClusterGroupA
          +     -0.1526681931709 * REP_ClusterGroupB
          +     0.15977077013006 * REP_ClusterGroupC
          +      0.2523378639337 * REP_ClusterGroupD
          +     0.19472373392086 * REP_ClusterGroupE
          +     0.06339538288443 * REP_ClusterGroupF
          +    -0.13626615937244 * REP_GenderF  +     0.00644992253244 * 
        REP_RegionCentral  +    -0.07767640867412 * REP_RegionNorth
          +    -0.16803088891237 * REP_RegionNorthEast
          +    -0.07961540921729 * REP_RegionSouth_East
          +     0.13429219310708 * REP_RegionSouth_West ;
   H124  = H124  +     0.05004490809247 * LoyaltyClassGold
          +    -0.06443809385767 * REP_AdvertisementZonBorder
          +    -0.03797337375468 * REP_AdvertisementZonCentral_Z1
          +    -0.16048641510259 * REP_AdvertisementZonE_Central
          +     0.03125524214178 * REP_AdvertisementZonN_Central
          +     0.01820092842612 * REP_AdvertisementZonN_East
          +    -0.22445786029025 * REP_AdvertisementZonN_West
          +     0.15915870041966 * REP_AdvertisementZonNE_Z1
          +    -0.04023576132233 * REP_AdvertisementZonNE_Z2
          +     0.19239693178614 * REP_AdvertisementZonNE_Z3
          +     -0.1364311928389 * REP_AdvertisementZonS_Central
          +     0.07952111753841 * REP_AdvertisementZonS_East
          +    -0.13395947660905 * REP_AdvertisementZonS_West
          +    -0.14810934454544 * REP_AdvertisementZonU
          +    -0.20420142845267 * REP_ClusterGroupA
          +    -0.10595095153296 * REP_ClusterGroupB
          +    -0.14150676890622 * REP_ClusterGroupC
          +    -0.02937533299515 * REP_ClusterGroupD
          +    -0.15764355523946 * REP_ClusterGroupE
          +    -0.10195803214706 * REP_ClusterGroupF
          +    -0.01135429033006 * REP_GenderF  +    -0.21818636974095 * 
        REP_RegionCentral  +     0.09879423047336 * REP_RegionNorth
          +     0.10844394385346 * REP_RegionNorthEast
          +    -0.05942707402861 * REP_RegionSouth_East
          +    -0.12671476812654 * REP_RegionSouth_West ;
   H125  = H125  +     0.00074973386332 * LoyaltyClassGold
          +    -0.09936296101793 * REP_AdvertisementZonBorder
          +     0.03323302905258 * REP_AdvertisementZonCentral_Z1
          +     0.01171082978835 * REP_AdvertisementZonE_Central
          +    -0.04280057264734 * REP_AdvertisementZonN_Central
          +    -0.23662632557553 * REP_AdvertisementZonN_East
          +    -0.17638548490389 * REP_AdvertisementZonN_West
          +    -0.19312693152085 * REP_AdvertisementZonNE_Z1
          +    -0.15185404925601 * REP_AdvertisementZonNE_Z2
          +     0.15337231749598 * REP_AdvertisementZonNE_Z3
          +    -0.14839480451736 * REP_AdvertisementZonS_Central
          +     0.19311497718896 * REP_AdvertisementZonS_East
          +    -0.03465219969244 * REP_AdvertisementZonS_West
          +    -0.17201869967869 * REP_AdvertisementZonU
          +     0.18072337679206 * REP_ClusterGroupA
          +     0.22480256069104 * REP_ClusterGroupB
          +    -0.11708032554855 * REP_ClusterGroupC
          +    -0.02173658490929 * REP_ClusterGroupD
          +    -0.14353043987851 * REP_ClusterGroupE
          +     -0.0204221116835 * REP_ClusterGroupF
          +     0.02640725736429 * REP_GenderF  +    -0.15634584077814 * 
        REP_RegionCentral  +     0.19786079518223 * REP_RegionNorth
          +    -0.14461011132102 * REP_RegionNorthEast
          +    -0.01688557253787 * REP_RegionSouth_East
          +     0.18797019273856 * REP_RegionSouth_West ;
   H126  = H126  +    -0.21189246710088 * LoyaltyClassGold
          +    -0.13011412941915 * REP_AdvertisementZonBorder
          +     0.33701344556339 * REP_AdvertisementZonCentral_Z1
          +      0.0356575509109 * REP_AdvertisementZonE_Central
          +     0.07993580173822 * REP_AdvertisementZonN_Central
          +      0.3073022874924 * REP_AdvertisementZonN_East
          +     0.07401055398243 * REP_AdvertisementZonN_West
          +    -0.27129403279443 * REP_AdvertisementZonNE_Z1
          +     0.13421702158304 * REP_AdvertisementZonNE_Z2
          +    -0.02207445224723 * REP_AdvertisementZonNE_Z3
          +     0.00722424431741 * REP_AdvertisementZonS_Central
          +     0.17985121001546 * REP_AdvertisementZonS_East
          +     0.08597352745457 * REP_AdvertisementZonS_West
          +     0.19908201653709 * REP_AdvertisementZonU
          +    -0.30459927666922 * REP_ClusterGroupA
          +    -0.22281539274883 * REP_ClusterGroupB
          +    -0.04066745663607 * REP_ClusterGroupC
          +     0.00277495256464 * REP_ClusterGroupD
          +     0.01726709503295 * REP_ClusterGroupE
          +     0.15307397343547 * REP_ClusterGroupF
          +    -0.10003402253535 * REP_GenderF  +     0.16540623927049 * 
        REP_RegionCentral  +     0.05643713478819 * REP_RegionNorth
          +    -0.04462353670755 * REP_RegionNorthEast
          +     -0.0165184362683 * REP_RegionSouth_East
          +    -0.20030929730277 * REP_RegionSouth_West ;
   H127  = H127  +    -0.06401732375821 * LoyaltyClassGold
          +     0.19409664869346 * REP_AdvertisementZonBorder
          +    -0.00809083267039 * REP_AdvertisementZonCentral_Z1
          +    -0.10617251079727 * REP_AdvertisementZonE_Central
          +     0.15845127311827 * REP_AdvertisementZonN_Central
          +    -0.01505617594764 * REP_AdvertisementZonN_East
          +     0.29136901573136 * REP_AdvertisementZonN_West
          +    -0.11407381804509 * REP_AdvertisementZonNE_Z1
          +     0.04397856943503 * REP_AdvertisementZonNE_Z2
          +    -0.23362798794256 * REP_AdvertisementZonNE_Z3
          +    -0.17772104468455 * REP_AdvertisementZonS_Central
          +     0.07420541181275 * REP_AdvertisementZonS_East
          +     0.02044835683432 * REP_AdvertisementZonS_West
          +    -0.21719435214548 * REP_AdvertisementZonU
          +     0.03969070174794 * REP_ClusterGroupA
          +    -0.01392557092714 * REP_ClusterGroupB
          +     0.13028193676687 * REP_ClusterGroupC
          +     0.17483432548048 * REP_ClusterGroupD
          +      0.1284648328841 * REP_ClusterGroupE
          +     0.03579753160262 * REP_ClusterGroupF
          +     0.23285394629693 * REP_GenderF  +    -0.00806390958224 * 
        REP_RegionCentral  +     0.22754238270622 * REP_RegionNorth
          +     0.38355198851662 * REP_RegionNorthEast
          +     0.14939548694146 * REP_RegionSouth_East
          +    -0.27423642863254 * REP_RegionSouth_West ;
   H128  = H128  +    -0.03659625492736 * LoyaltyClassGold
          +    -0.03671617742424 * REP_AdvertisementZonBorder
          +      0.0191795624103 * REP_AdvertisementZonCentral_Z1
          +     0.00319991223791 * REP_AdvertisementZonE_Central
          +    -0.01264966110206 * REP_AdvertisementZonN_Central
          +     0.09149316718012 * REP_AdvertisementZonN_East
          +    -0.01873998680338 * REP_AdvertisementZonN_West
          +     0.19733808736876 * REP_AdvertisementZonNE_Z1
          +    -0.02524943402999 * REP_AdvertisementZonNE_Z2
          +     0.39171954074141 * REP_AdvertisementZonNE_Z3
          +     0.15040879313444 * REP_AdvertisementZonS_Central
          +     0.25287857150371 * REP_AdvertisementZonS_East
          +      0.1817305108595 * REP_AdvertisementZonS_West
          +     0.07590557658005 * REP_AdvertisementZonU
          +    -0.29047500854514 * REP_ClusterGroupA
          +     0.30331874231174 * REP_ClusterGroupB
          +    -0.07204184268504 * REP_ClusterGroupC
          +     0.31107382352287 * REP_ClusterGroupD
          +    -0.06766555098778 * REP_ClusterGroupE
          +     0.07140579841813 * REP_ClusterGroupF
          +    -0.05073015048765 * REP_GenderF  +    -0.10899642908619 * 
        REP_RegionCentral  +     0.05915828839481 * REP_RegionNorth
          +     0.02712308986862 * REP_RegionNorthEast
          +      0.1453138369683 * REP_RegionSouth_East
          +    -0.17610875498758 * REP_RegionSouth_West ;
   H129  = H129  +     -0.3084870483825 * LoyaltyClassGold
          +     0.31425514390972 * REP_AdvertisementZonBorder
          +     0.18221201064083 * REP_AdvertisementZonCentral_Z1
          +    -0.33433946564047 * REP_AdvertisementZonE_Central
          +    -0.05513688076181 * REP_AdvertisementZonN_Central
          +    -0.00215335552342 * REP_AdvertisementZonN_East
          +    -0.02084714910593 * REP_AdvertisementZonN_West
          +     0.14055852160645 * REP_AdvertisementZonNE_Z1
          +     0.22748137432865 * REP_AdvertisementZonNE_Z2
          +    -0.20200434978146 * REP_AdvertisementZonNE_Z3
          +     0.06331994151106 * REP_AdvertisementZonS_Central
          +     0.04717571011976 * REP_AdvertisementZonS_East
          +      0.0067402938423 * REP_AdvertisementZonS_West
          +    -0.14268758788789 * REP_AdvertisementZonU
          +     0.17086819886319 * REP_ClusterGroupA
          +     0.21644080369341 * REP_ClusterGroupB
          +     0.15948867168682 * REP_ClusterGroupC
          +    -0.06710319692212 * REP_ClusterGroupD
          +     0.09224545258892 * REP_ClusterGroupE
          +     0.06761701645026 * REP_ClusterGroupF
          +     0.01561729644092 * REP_GenderF  +     0.18526370736779 * 
        REP_RegionCentral  +     0.14051369617042 * REP_RegionNorth
          +     0.20883643749514 * REP_RegionNorthEast
          +     0.44194544846579 * REP_RegionSouth_East
          +    -0.05253616641093 * REP_RegionSouth_West ;
   H130  = H130  +     0.19957116508021 * LoyaltyClassGold
          +     0.32245280818352 * REP_AdvertisementZonBorder
          +     0.05208711302119 * REP_AdvertisementZonCentral_Z1
          +    -0.18042984832564 * REP_AdvertisementZonE_Central
          +     0.25073184776907 * REP_AdvertisementZonN_Central
          +     -0.0967825763314 * REP_AdvertisementZonN_East
          +    -0.21968916394124 * REP_AdvertisementZonN_West
          +     -0.0973366804153 * REP_AdvertisementZonNE_Z1
          +    -0.06293079903262 * REP_AdvertisementZonNE_Z2
          +    -0.04053437667952 * REP_AdvertisementZonNE_Z3
          +     0.32014697724454 * REP_AdvertisementZonS_Central
          +     0.14308358778747 * REP_AdvertisementZonS_East
          +     0.22680386650008 * REP_AdvertisementZonS_West
          +     0.07204515215201 * REP_AdvertisementZonU
          +     0.00485931912139 * REP_ClusterGroupA
          +    -0.25522338205727 * REP_ClusterGroupB
          +    -0.00405911759089 * REP_ClusterGroupC
          +     -0.0866674377039 * REP_ClusterGroupD
          +     0.07794257486584 * REP_ClusterGroupE
          +    -0.07020828468706 * REP_ClusterGroupF
          +     0.23602648884343 * REP_GenderF  +     0.09699702358448 * 
        REP_RegionCentral  +     -0.1189385119954 * REP_RegionNorth
          +     0.07662733632759 * REP_RegionNorthEast
          +    -0.25446742297955 * REP_RegionSouth_East
          +     0.14269577769359 * REP_RegionSouth_West ;
   H131  = H131  +     0.17520112846311 * LoyaltyClassGold
          +     0.08681308049047 * REP_AdvertisementZonBorder
          +     0.11171309349947 * REP_AdvertisementZonCentral_Z1
          +     0.02098919912025 * REP_AdvertisementZonE_Central
          +    -0.15949529653439 * REP_AdvertisementZonN_Central
          +    -0.10597971476408 * REP_AdvertisementZonN_East
          +     0.28403186166881 * REP_AdvertisementZonN_West
          +     0.03445360588493 * REP_AdvertisementZonNE_Z1
          +    -0.15465436855008 * REP_AdvertisementZonNE_Z2
          +     0.01623402652943 * REP_AdvertisementZonNE_Z3
          +     0.22938794300346 * REP_AdvertisementZonS_Central
          +    -0.02188344069826 * REP_AdvertisementZonS_East
          +     0.02315834592903 * REP_AdvertisementZonS_West
          +    -0.02060442836905 * REP_AdvertisementZonU
          +    -0.26645897843781 * REP_ClusterGroupA
          +      0.0203271402788 * REP_ClusterGroupB
          +    -0.17999167652409 * REP_ClusterGroupC
          +    -0.20753889344571 * REP_ClusterGroupD
          +     0.27006761290196 * REP_ClusterGroupE
          +     0.12257209756455 * REP_ClusterGroupF
          +     0.08829836723831 * REP_GenderF  +    -0.00083819924037 * 
        REP_RegionCentral  +     0.23735913813515 * REP_RegionNorth
          +    -0.08245737196015 * REP_RegionNorthEast
          +    -0.04638898399259 * REP_RegionSouth_East
          +    -0.17379909226712 * REP_RegionSouth_West ;
   H132  = H132  +    -0.26374636832707 * LoyaltyClassGold
          +    -0.07609101875015 * REP_AdvertisementZonBorder
          +    -0.07441729932292 * REP_AdvertisementZonCentral_Z1
          +    -0.18716828642828 * REP_AdvertisementZonE_Central
          +    -0.04119896076808 * REP_AdvertisementZonN_Central
          +     0.02705746025852 * REP_AdvertisementZonN_East
          +     0.13850231011863 * REP_AdvertisementZonN_West
          +    -0.45491832756982 * REP_AdvertisementZonNE_Z1
          +     0.01260479738015 * REP_AdvertisementZonNE_Z2
          +    -0.02553975715751 * REP_AdvertisementZonNE_Z3
          +      0.2031294289597 * REP_AdvertisementZonS_Central
          +    -0.00849202304762 * REP_AdvertisementZonS_East
          +    -0.07280818378728 * REP_AdvertisementZonS_West
          +     0.12975961038514 * REP_AdvertisementZonU
          +     0.04464628773079 * REP_ClusterGroupA
          +    -0.03693436370941 * REP_ClusterGroupB
          +    -0.10985699964348 * REP_ClusterGroupC
          +     0.08896317827295 * REP_ClusterGroupD
          +     0.09767293248678 * REP_ClusterGroupE
          +    -0.17613412943154 * REP_ClusterGroupF
          +    -0.21454386133458 * REP_GenderF  +     0.11474208014397 * 
        REP_RegionCentral  +    -0.02681065347812 * REP_RegionNorth
          +     0.17824982249172 * REP_RegionNorthEast
          +    -0.09822591190042 * REP_RegionSouth_East
          +     0.09843896161913 * REP_RegionSouth_West ;
   H101  =    -0.34127389681674 + H101 ;
   H102  =    -1.31529761584229 + H102 ;
   H103  =      -0.432639183016 + H103 ;
   H104  =     0.54226658172098 + H104 ;
   H105  =      1.2255917713334 + H105 ;
   H106  =     1.03121532032047 + H106 ;
   H107  =    -0.10199181705201 + H107 ;
   H108  =     0.00294719328002 + H108 ;
   H109  =    -0.75079371423744 + H109 ;
   H110  =     -0.2642629365764 + H110 ;
   H111  =     0.14962923128802 + H111 ;
   H112  =    -0.23886048895403 + H112 ;
   H113  =    -1.24600738758187 + H113 ;
   H114  =     1.06432836221221 + H114 ;
   H115  =      -0.505251761717 + H115 ;
   H116  =     0.48308864866854 + H116 ;
   H117  =     3.84023386221533 + H117 ;
   H118  =     0.72872164935321 + H118 ;
   H119  =    -0.46420824671098 + H119 ;
   H120  =     1.21691626103918 + H120 ;
   H121  =     0.25121044867802 + H121 ;
   H122  =     1.45797810122755 + H122 ;
   H123  =    -0.25096031136413 + H123 ;
   H124  =     0.19285352515508 + H124 ;
   H125  =    -0.65392570856928 + H125 ;
   H126  =    -0.45106359418283 + H126 ;
   H127  =     0.36815989167192 + H127 ;
   H128  =    -1.06091358529583 + H128 ;
   H129  =     0.13232779501599 + H129 ;
   H130  =    -0.17436965566073 + H130 ;
   H131  =     1.02723352254153 + H131 ;
   H132  =    -1.67264775317144 + H132 ;
   H101  = TANH(H101 );
   H102  = TANH(H102 );
   H103  = TANH(H103 );
   H104  = TANH(H104 );
   H105  = TANH(H105 );
   H106  = TANH(H106 );
   H107  = TANH(H107 );
   H108  = TANH(H108 );
   H109  = TANH(H109 );
   H110  = TANH(H110 );
   H111  = TANH(H111 );
   H112  = TANH(H112 );
   H113  = TANH(H113 );
   H114  = TANH(H114 );
   H115  = TANH(H115 );
   H116  = TANH(H116 );
   H117  = TANH(H117 );
   H118  = TANH(H118 );
   H119  = TANH(H119 );
   H120  = TANH(H120 );
   H121  = TANH(H121 );
   H122  = TANH(H122 );
   H123  = TANH(H123 );
   H124  = TANH(H124 );
   H125  = TANH(H125 );
   H126  = TANH(H126 );
   H127  = TANH(H127 );
   H128  = TANH(H128 );
   H129  = TANH(H129 );
   H130  = TANH(H130 );
   H131  = TANH(H131 );
   H132  = TANH(H132 );
END;
ELSE DO;
   H101  = .;
   H102  = .;
   H103  = .;
   H104  = .;
   H105  = .;
   H106  = .;
   H107  = .;
   H108  = .;
   H109  = .;
   H110  = .;
   H111  = .;
   H112  = .;
   H113  = .;
   H114  = .;
   H115  = .;
   H116  = .;
   H117  = .;
   H118  = .;
   H119  = .;
   H120  = .;
   H121  = .;
   H122  = .;
   H123  = .;
   H124  = .;
   H125  = .;
   H126  = .;
   H127  = .;
   H128  = .;
   H129  = .;
   H130  = .;
   H131  = .;
   H132  = .;
END;
*** *************************;
*** Writing the Node TargetBuy ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_TargetBuy1  =    -0.09159376272039 * H101  +     0.26075484149934 * H102
          +     0.08774681303263 * H103  +    -0.58629318485576 * H104
          +     0.35463828272285 * H105  +     0.07526275536956 * H106
          +    -1.43179994291559 * H107  +    -0.61960170158576 * H108
          +    -0.94498822852431 * H109  +    -0.85265050190426 * H110
          +     0.60845294219991 * H111  +    -0.04281801340151 * H112
          +    -0.04257666039875 * H113  +     0.22618187546094 * H114
          +    -1.26694130577067 * H115  +    -0.97996673730986 * H116
          +    -0.17347050663872 * H117  +    -0.76682129277779 * H118
          +     0.36856385597804 * H119  +     0.19590221157263 * H120
          +     0.62749236435767 * H121  +    -1.49310310866918 * H122
          +    -0.09299597373263 * H123  +     0.15815344146347 * H124
          +    -0.87387545721785 * H125  +    -0.00975596767377 * H126
          +     0.03414903144535 * H127  +     0.42380687473267 * H128
          +     0.26588844883632 * H129  +     1.38181610391032 * H130
          +     0.40687031133503 * H131  +     0.06769126326925 * H132 ;
   P_TargetBuy1  =    -0.76007945365025 + P_TargetBuy1 ;
   P_TargetBuy0  = 0; 
   _MAX_ = MAX (P_TargetBuy1 , P_TargetBuy0 );
   _SUM_ = 0.; 
   P_TargetBuy1  = EXP(P_TargetBuy1  - _MAX_);
   _SUM_ = _SUM_ + P_TargetBuy1 ;
   P_TargetBuy0  = EXP(P_TargetBuy0  - _MAX_);
   _SUM_ = _SUM_ + P_TargetBuy0 ;
   P_TargetBuy1  = P_TargetBuy1  / _SUM_;
   P_TargetBuy0  = P_TargetBuy0  / _SUM_;
END;
ELSE DO;
   P_TargetBuy1  = .;
   P_TargetBuy0  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_TargetBuy1  =     0.35953346855983;
   P_TargetBuy0  =     0.64046653144016;
END;
*** *************************;
*** Writing the I_TargetBuy  AND U_TargetBuy ;
*** *************************;
_MAXP_ = P_TargetBuy1 ;
I_TargetBuy  = "1           " ;
U_TargetBuy  =                    1;
IF( _MAXP_ LT P_TargetBuy0  ) THEN DO; 
   _MAXP_ = P_TargetBuy0 ;
   I_TargetBuy  = "0           " ;
   U_TargetBuy  =                    0;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
