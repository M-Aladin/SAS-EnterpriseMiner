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
      F_TargetBuy  $ 12
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

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label H14 = 'Hidden: H1=4' ;

      label H15 = 'Hidden: H1=5' ;

      label H16 = 'Hidden: H1=6' ;

      label I_TargetBuy = 'Into: TargetBuy' ;

      label F_TargetBuy = 'From: TargetBuy' ;

      label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;

      label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;

      label R_TargetBuy1 = 'Residual: TargetBuy=1' ;

      label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;

      label R_TargetBuy0 = 'Residual: TargetBuy=0' ;

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
   H11  =     0.14371339703655 * S_AffluenceGrade  +    -0.08024414993663 *
        S_CleanserProducts  +     0.00924516098119 * S_DayCareProducts
          +     0.12429625401427 * S_LotionProducts  +     0.02331090917375 *
        S_NightRepairProducts  +      0.1644666289938 * S_REP_Age
          +     -0.3289334176266 * S_REP_LoyaltyTime
          +     0.17908062112569 * S_TimeSinceLastPurchase
          +    -0.10921756135767 * S_TotalSpend ;
   H12  =    -0.13751489902137 * S_AffluenceGrade  +     0.02975049681892 *
        S_CleanserProducts  +     0.17000702481159 * S_DayCareProducts
          +    -0.12494368127372 * S_LotionProducts  +     0.17509966436858 *
        S_NightRepairProducts  +      0.0137292955292 * S_REP_Age
          +    -0.44669019848549 * S_REP_LoyaltyTime
          +     0.13337744570297 * S_TimeSinceLastPurchase
          +    -0.02437296278089 * S_TotalSpend ;
   H13  =    -0.20610180823232 * S_AffluenceGrade  +     0.07329701207879 *
        S_CleanserProducts  +    -0.02229878022655 * S_DayCareProducts
          +     0.27765133760183 * S_LotionProducts  +    -0.17477479581843 *
        S_NightRepairProducts  +     0.05549937216515 * S_REP_Age
          +    -0.03153381969441 * S_REP_LoyaltyTime
          +    -0.23583661191518 * S_TimeSinceLastPurchase
          +     0.22114183574168 * S_TotalSpend ;
   H14  =    -0.22763769435952 * S_AffluenceGrade  +    -0.15378961680958 *
        S_CleanserProducts  +    -0.17163627452036 * S_DayCareProducts
          +     0.13388005314696 * S_LotionProducts  +    -0.11275309333155 *
        S_NightRepairProducts  +    -0.09481428005042 * S_REP_Age
          +    -0.13942566801219 * S_REP_LoyaltyTime
          +     0.01751537044309 * S_TimeSinceLastPurchase
          +     -0.1619586739426 * S_TotalSpend ;
   H15  =    -0.23930008357111 * S_AffluenceGrade  +    -0.06009623041791 *
        S_CleanserProducts  +     -0.0004521014267 * S_DayCareProducts
          +    -0.18659234207947 * S_LotionProducts  +    -0.04575545526982 *
        S_NightRepairProducts  +     1.07319905932213 * S_REP_Age
          +    -0.06402996067892 * S_REP_LoyaltyTime
          +     0.00296778303443 * S_TimeSinceLastPurchase
          +     0.09426180519273 * S_TotalSpend ;
   H16  =     0.20701087916455 * S_AffluenceGrade  +     -0.0647138609434 *
        S_CleanserProducts  +     0.12971464956355 * S_DayCareProducts
          +    -0.01456461367813 * S_LotionProducts  +     0.06132974381194 *
        S_NightRepairProducts  +    -0.26862773428907 * S_REP_Age
          +     0.10151422025924 * S_REP_LoyaltyTime
          +    -0.09152638125774 * S_TimeSinceLastPurchase
          +    -0.25124649419161 * S_TotalSpend ;
   H11  = H11  +    -0.09857989199604 * CampaignViewedEmail0
          +    -0.41446896873246 * MobileApplications0
          +     0.26753138827962 * PreviousCampaign0 ;
   H12  = H12  +     0.14961610309636 * CampaignViewedEmail0
          +    -0.05304706346158 * MobileApplications0
          +    -0.27281374877348 * PreviousCampaign0 ;
   H13  = H13  +     -0.3647224795393 * CampaignViewedEmail0
          +     0.16125063280172 * MobileApplications0
          +    -0.27751758730121 * PreviousCampaign0 ;
   H14  = H14  +    -0.01391199514637 * CampaignViewedEmail0
          +    -0.32672657362983 * MobileApplications0
          +     0.33412844201137 * PreviousCampaign0 ;
   H15  = H15  +    -0.12375891178454 * CampaignViewedEmail0
          +     0.19559627967645 * MobileApplications0
          +     0.03682627466816 * PreviousCampaign0 ;
   H16  = H16  +    -0.14123306507252 * CampaignViewedEmail0
          +    -0.52919194183014 * MobileApplications0
          +    -0.35943721127914 * PreviousCampaign0 ;
   H11  = H11  +    -0.00832457310083 * LoyaltyClassGold
          +    -0.00984708898858 * REP_AdvertisementZonBorder
          +    -0.17126535744162 * REP_AdvertisementZonCentral_Z1
          +     0.10958713263684 * REP_AdvertisementZonE_Central
          +      0.1481703298831 * REP_AdvertisementZonN_Central
          +     -0.0028246349415 * REP_AdvertisementZonN_East
          +    -0.08432173572633 * REP_AdvertisementZonN_West
          +     0.01757657354386 * REP_AdvertisementZonNE_Z1
          +     0.17565606865441 * REP_AdvertisementZonNE_Z2
          +    -0.11878141928665 * REP_AdvertisementZonNE_Z3
          +    -0.00533897465844 * REP_AdvertisementZonS_Central
          +    -0.07506170894555 * REP_AdvertisementZonS_East
          +     0.21925675553837 * REP_AdvertisementZonS_West
          +     0.17855438775309 * REP_AdvertisementZonU
          +    -0.04411893561698 * REP_ClusterGroupA
          +    -0.07809127800088 * REP_ClusterGroupB
          +     0.02411697182383 * REP_ClusterGroupC
          +     0.01351856048967 * REP_ClusterGroupD
          +    -0.28580547608814 * REP_ClusterGroupE
          +     0.19383747899554 * REP_ClusterGroupF
          +      0.0639798269999 * REP_GenderF  +    -0.06388461802421 *
        REP_RegionCentral  +     0.32591411266289 * REP_RegionNorth
          +     0.27475194668466 * REP_RegionNorthEast
          +     0.12238341720528 * REP_RegionSouth_East
          +     0.02463067170329 * REP_RegionSouth_West ;
   H12  = H12  +    -0.00759407323284 * LoyaltyClassGold
          +    -0.12466166187096 * REP_AdvertisementZonBorder
          +    -0.02859221037772 * REP_AdvertisementZonCentral_Z1
          +    -0.04020852984194 * REP_AdvertisementZonE_Central
          +     0.02835154316536 * REP_AdvertisementZonN_Central
          +    -0.13349763328836 * REP_AdvertisementZonN_East
          +     -0.1235273477303 * REP_AdvertisementZonN_West
          +     0.03944649943475 * REP_AdvertisementZonNE_Z1
          +    -0.16558460607833 * REP_AdvertisementZonNE_Z2
          +     0.03895874025412 * REP_AdvertisementZonNE_Z3
          +    -0.07679360441791 * REP_AdvertisementZonS_Central
          +     0.13471083036747 * REP_AdvertisementZonS_East
          +     0.17349080096587 * REP_AdvertisementZonS_West
          +    -0.30256187853603 * REP_AdvertisementZonU
          +    -0.31200899872249 * REP_ClusterGroupA
          +     0.01090228741324 * REP_ClusterGroupB
          +     -0.1436764111566 * REP_ClusterGroupC
          +     0.16755049887718 * REP_ClusterGroupD
          +    -0.00863342675838 * REP_ClusterGroupE
          +     0.14346583172193 * REP_ClusterGroupF
          +    -0.06284790706479 * REP_GenderF  +    -0.09313189959639 *
        REP_RegionCentral  +    -0.22157570659692 * REP_RegionNorth
          +    -0.13441868193833 * REP_RegionNorthEast
          +     0.01325533445993 * REP_RegionSouth_East
          +    -0.03144192017058 * REP_RegionSouth_West ;
   H13  = H13  +     0.22519037517213 * LoyaltyClassGold
          +    -0.29076789466452 * REP_AdvertisementZonBorder
          +     0.20250767533638 * REP_AdvertisementZonCentral_Z1
          +    -0.08366049851053 * REP_AdvertisementZonE_Central
          +     0.15296803465083 * REP_AdvertisementZonN_Central
          +     0.27168822362262 * REP_AdvertisementZonN_East
          +    -0.03002052104095 * REP_AdvertisementZonN_West
          +    -0.23831734736992 * REP_AdvertisementZonNE_Z1
          +    -0.34649334101093 * REP_AdvertisementZonNE_Z2
          +     0.13484897835446 * REP_AdvertisementZonNE_Z3
          +     0.17407569931944 * REP_AdvertisementZonS_Central
          +     0.06955973234089 * REP_AdvertisementZonS_East
          +    -0.14098495396413 * REP_AdvertisementZonS_West
          +      0.0848936408269 * REP_AdvertisementZonU
          +     0.11310205744246 * REP_ClusterGroupA
          +    -0.11195939140986 * REP_ClusterGroupB
          +    -0.03417858180816 * REP_ClusterGroupC
          +    -0.15779075301514 * REP_ClusterGroupD
          +    -0.25322312197871 * REP_ClusterGroupE
          +     0.16980490015821 * REP_ClusterGroupF
          +     0.07845009256611 * REP_GenderF  +     0.03584391811738 *
        REP_RegionCentral  +     0.28155417058746 * REP_RegionNorth
          +    -0.03055276995473 * REP_RegionNorthEast
          +     0.28864170735916 * REP_RegionSouth_East
          +     0.10642618345405 * REP_RegionSouth_West ;
   H14  = H14  +     0.10443272720502 * LoyaltyClassGold
          +     0.23815073651407 * REP_AdvertisementZonBorder
          +    -0.17817136346516 * REP_AdvertisementZonCentral_Z1
          +     0.25782290699214 * REP_AdvertisementZonE_Central
          +    -0.12290405349685 * REP_AdvertisementZonN_Central
          +    -0.18543584217252 * REP_AdvertisementZonN_East
          +     0.28138058172078 * REP_AdvertisementZonN_West
          +     0.13234275689712 * REP_AdvertisementZonNE_Z1
          +    -0.11938471191855 * REP_AdvertisementZonNE_Z2
          +    -0.03403393446255 * REP_AdvertisementZonNE_Z3
          +    -0.22457655699352 * REP_AdvertisementZonS_Central
          +     0.11814905089208 * REP_AdvertisementZonS_East
          +    -0.04020935553709 * REP_AdvertisementZonS_West
          +     0.11947443588909 * REP_AdvertisementZonU
          +    -0.34725808765599 * REP_ClusterGroupA
          +     0.16813179407556 * REP_ClusterGroupB
          +     0.05179410703769 * REP_ClusterGroupC
          +    -0.11900958972629 * REP_ClusterGroupD
          +    -0.24285895425599 * REP_ClusterGroupE
          +     0.16437026658153 * REP_ClusterGroupF
          +    -0.54461991221214 * REP_GenderF  +     0.24886231798205 *
        REP_RegionCentral  +     0.09836744105277 * REP_RegionNorth
          +      0.1106811205741 * REP_RegionNorthEast
          +    -0.15693229304803 * REP_RegionSouth_East
          +    -0.28015717114629 * REP_RegionSouth_West ;
   H15  = H15  +    -0.12637854763984 * LoyaltyClassGold
          +     0.04524224168969 * REP_AdvertisementZonBorder
          +    -0.09491226808299 * REP_AdvertisementZonCentral_Z1
          +     0.08289288806831 * REP_AdvertisementZonE_Central
          +    -0.13168442158895 * REP_AdvertisementZonN_Central
          +    -0.05955292793992 * REP_AdvertisementZonN_East
          +    -0.11561854165564 * REP_AdvertisementZonN_West
          +     0.16682215295179 * REP_AdvertisementZonNE_Z1
          +    -0.13735325285157 * REP_AdvertisementZonNE_Z2
          +     0.09966113036286 * REP_AdvertisementZonNE_Z3
          +    -0.06586530088606 * REP_AdvertisementZonS_Central
          +     0.07647280334643 * REP_AdvertisementZonS_East
          +     0.08780811211503 * REP_AdvertisementZonS_West
          +    -0.11533101562525 * REP_AdvertisementZonU
          +     0.28983964621381 * REP_ClusterGroupA
          +     0.05618768827361 * REP_ClusterGroupB
          +     0.10657430263172 * REP_ClusterGroupC
          +      0.0781828109827 * REP_ClusterGroupD
          +    -0.08973672602314 * REP_ClusterGroupE
          +     -0.0121269289319 * REP_ClusterGroupF
          +     -0.0710288240213 * REP_GenderF  +    -0.14234816246747 *
        REP_RegionCentral  +     0.18351533522131 * REP_RegionNorth
          +    -0.18070371059378 * REP_RegionNorthEast
          +     0.05439529951001 * REP_RegionSouth_East
          +    -0.04348593722776 * REP_RegionSouth_West ;
   H16  = H16  +    -0.27278345745323 * LoyaltyClassGold
          +    -0.17174133827879 * REP_AdvertisementZonBorder
          +     0.16790182532406 * REP_AdvertisementZonCentral_Z1
          +    -0.01364411063066 * REP_AdvertisementZonE_Central
          +    -0.19564382706169 * REP_AdvertisementZonN_Central
          +    -0.06626787208655 * REP_AdvertisementZonN_East
          +    -0.02712634980626 * REP_AdvertisementZonN_West
          +     0.22122729640244 * REP_AdvertisementZonNE_Z1
          +    -0.50147454014519 * REP_AdvertisementZonNE_Z2
          +     0.07213622953963 * REP_AdvertisementZonNE_Z3
          +     0.06126724865318 * REP_AdvertisementZonS_Central
          +    -0.14270908254983 * REP_AdvertisementZonS_East
          +    -0.07934086734907 * REP_AdvertisementZonS_West
          +     0.08786414201835 * REP_AdvertisementZonU
          +    -0.06520984368141 * REP_ClusterGroupA
          +     0.02327745616865 * REP_ClusterGroupB
          +    -0.04979520498828 * REP_ClusterGroupC
          +    -0.00281698185576 * REP_ClusterGroupD
          +     0.14644888705636 * REP_ClusterGroupE
          +     0.02267845221861 * REP_ClusterGroupF
          +    -0.05202622803467 * REP_GenderF  +      -0.305249487525 *
        REP_RegionCentral  +    -0.05645857653376 * REP_RegionNorth
          +    -0.25584491550137 * REP_RegionNorthEast
          +    -0.06822392681787 * REP_RegionSouth_East
          +    -0.05365978699339 * REP_RegionSouth_West ;
   H11  =     1.19276139126631 + H11 ;
   H12  =     1.46918660697128 + H12 ;
   H13  =    -1.39019604092487 + H13 ;
   H14  =    -0.48826592938494 + H14 ;
   H15  =     1.62435083048873 + H15 ;
   H16  =    -0.47306152113068 + H16 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
END;
*** *************************;
*** Writing the Node TargetBuy ;
*** *************************;

*** Generate dummy variables for TargetBuy ;
drop TargetBuy1 TargetBuy0 ;
label F_TargetBuy = 'From: TargetBuy' ;
length F_TargetBuy $ 12;
F_TargetBuy = put( TargetBuy , BEST12. );
%DMNORMIP( F_TargetBuy )
if missing( TargetBuy ) then do;
   TargetBuy1 = .;
   TargetBuy0 = .;
end;
else do;
   if F_TargetBuy = '0'  then do;
      TargetBuy1 = 0;
      TargetBuy0 = 1;
   end;
   else if F_TargetBuy = '1'  then do;
      TargetBuy1 = 1;
      TargetBuy0 = 0;
   end;
   else do;
      TargetBuy1 = .;
      TargetBuy0 = .;
   end;
end;
IF _DM_BAD EQ 0 THEN DO;
   P_TargetBuy1  =     2.35652884542717 * H11  +    -0.37304159475321 * H12
          +    -0.40248323989296 * H13  +    -2.16217347637487 * H14
          +    -2.30619090481738 * H15  +     1.07193573291101 * H16 ;
   P_TargetBuy1  =    -1.33139843752366 + P_TargetBuy1 ;
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
*** *****************************;
*** Writing the Residuals  of the Node TargetBuy ;
*** ******************************;
IF MISSING( TargetBuy1 ) THEN R_TargetBuy1  = . ;
ELSE R_TargetBuy1  = TargetBuy1  - P_TargetBuy1 ;
IF MISSING( TargetBuy0 ) THEN R_TargetBuy0  = . ;
ELSE R_TargetBuy0  = TargetBuy0  - P_TargetBuy0 ;
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
