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

      label H17 = 'Hidden: H1=7' ;

      label H18 = 'Hidden: H1=8' ;

      label H19 = 'Hidden: H1=9' ;

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
   else if _dm10 = 'N EAST'  then do;
      REP_AdvertisementZonN_East = 1;
   end;
   else if _dm10 = 'S WEST'  then do;
      REP_AdvertisementZonS_West = 1;
   end;
   else if _dm10 = 'NE Z1'  then do;
      REP_AdvertisementZonNE_Z1 = 1;
   end;
   else if _dm10 = 'U'  then do;
      REP_AdvertisementZonU = 1;
   end;
   else if _dm10 = 'N CENTRAL'  then do;
      REP_AdvertisementZonN_Central = 1;
   end;
   else if _dm10 = 'NE Z2'  then do;
      REP_AdvertisementZonNE_Z2 = 1;
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
   S_AffluenceGrade  =    -3.16012346520662 +     0.41943969298892 *
        AffluenceGrade ;
   S_CleanserProducts  =    -1.41873824772079 +     0.74176420094535 *
        CleanserProducts ;
   S_DayCareProducts  =    -1.31963544217747 +     0.87420953254041 *
        DayCareProducts ;
   S_LotionProducts  =    -1.42421522820046 +     0.65288716569969 *
        LotionProducts ;
   S_NightRepairProducts  =    -1.11809647261344 +     1.22061143037139 *
        NightRepairProducts ;
   S_REP_Age  =    -4.31633655846025 +     0.07883195718795 * REP_Age ;
   S_REP_LoyaltyTime  =    -1.81295530745606 +     0.30131566900395 *
        REP_LoyaltyTime ;
   S_TimeSinceLastPurchase  =     -1.4618088884206 +     0.46290614799985 *
        TimeSinceLastPurchase ;
   S_TotalSpend  =    -1.38839611243183 +     0.00068175057332 * TotalSpend ;
END;
ELSE DO;
   IF MISSING( AffluenceGrade ) THEN S_AffluenceGrade  = . ;
   ELSE S_AffluenceGrade  =    -3.16012346520662 +     0.41943969298892 *
        AffluenceGrade ;
   IF MISSING( CleanserProducts ) THEN S_CleanserProducts  = . ;
   ELSE S_CleanserProducts  =    -1.41873824772079 +     0.74176420094535 *
        CleanserProducts ;
   IF MISSING( DayCareProducts ) THEN S_DayCareProducts  = . ;
   ELSE S_DayCareProducts  =    -1.31963544217747 +     0.87420953254041 *
        DayCareProducts ;
   IF MISSING( LotionProducts ) THEN S_LotionProducts  = . ;
   ELSE S_LotionProducts  =    -1.42421522820046 +     0.65288716569969 *
        LotionProducts ;
   IF MISSING( NightRepairProducts ) THEN S_NightRepairProducts  = . ;
   ELSE S_NightRepairProducts
          =    -1.11809647261344 +     1.22061143037139 * NightRepairProducts
         ;
   IF MISSING( REP_Age ) THEN S_REP_Age  = . ;
   ELSE S_REP_Age  =    -4.31633655846025 +     0.07883195718795 * REP_Age ;
   IF MISSING( REP_LoyaltyTime ) THEN S_REP_LoyaltyTime  = . ;
   ELSE S_REP_LoyaltyTime  =    -1.81295530745606 +     0.30131566900395 *
        REP_LoyaltyTime ;
   IF MISSING( TimeSinceLastPurchase ) THEN S_TimeSinceLastPurchase  = . ;
   ELSE S_TimeSinceLastPurchase
          =     -1.4618088884206 +     0.46290614799985 *
        TimeSinceLastPurchase ;
   IF MISSING( TotalSpend ) THEN S_TotalSpend  = . ;
   ELSE S_TotalSpend  =    -1.38839611243183 +     0.00068175057332 *
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
   H11  =     0.29803107617223 * S_AffluenceGrade  +     0.02476865886043 *
        S_CleanserProducts  +      0.1239034931875 * S_DayCareProducts
          +      0.0278031049056 * S_LotionProducts  +     0.27296075625185 *
        S_NightRepairProducts  +     0.25866914073798 * S_REP_Age
          +    -0.35532004757839 * S_REP_LoyaltyTime
          +    -0.12446643644571 * S_TimeSinceLastPurchase
          +    -0.16251243298628 * S_TotalSpend ;
   H12  =     0.01539335440155 * S_AffluenceGrade  +     -0.2753370278923 *
        S_CleanserProducts  +     0.10967615615941 * S_DayCareProducts
          +    -0.09749090429589 * S_LotionProducts  +     0.34816744421373 *
        S_NightRepairProducts  +    -0.03427483624408 * S_REP_Age
          +     0.17327528322675 * S_REP_LoyaltyTime
          +     0.06756391440885 * S_TimeSinceLastPurchase
          +    -0.00562320182848 * S_TotalSpend ;
   H13  =     0.18649096382888 * S_AffluenceGrade  +     0.43757571834662 *
        S_CleanserProducts  +     0.30657846102799 * S_DayCareProducts
          +    -0.00312992438317 * S_LotionProducts  +     -0.3304833280217 *
        S_NightRepairProducts  +     0.78804388843462 * S_REP_Age
          +      0.4080344293645 * S_REP_LoyaltyTime
          +     -0.1984546378702 * S_TimeSinceLastPurchase
          +    -0.06180750469629 * S_TotalSpend ;
   H14  =     -0.5176219149725 * S_AffluenceGrade  +    -0.20085604867576 *
        S_CleanserProducts  +    -0.42348452038522 * S_DayCareProducts
          +     0.37842272203653 * S_LotionProducts  +    -0.15436284476792 *
        S_NightRepairProducts  +     0.24317496477646 * S_REP_Age
          +    -0.06079204394317 * S_REP_LoyaltyTime
          +    -0.12257451719573 * S_TimeSinceLastPurchase
          +    -0.78826290375774 * S_TotalSpend ;
   H15  =    -0.45120404577966 * S_AffluenceGrade  +    -0.28388724310282 *
        S_CleanserProducts  +      0.3508883806968 * S_DayCareProducts
          +       0.161854362714 * S_LotionProducts  +    -0.36452144946149 *
        S_NightRepairProducts  +    -0.00212678083644 * S_REP_Age
          +     -0.4599767221748 * S_REP_LoyaltyTime
          +     0.16845779127905 * S_TimeSinceLastPurchase
          +     0.53343065996393 * S_TotalSpend ;
   H16  =    -0.12050799712492 * S_AffluenceGrade  +     0.02617756080209 *
        S_CleanserProducts  +     0.57283323582883 * S_DayCareProducts
          +     0.59127039571012 * S_LotionProducts  +    -0.49855086846814 *
        S_NightRepairProducts  +    -0.23771988752958 * S_REP_Age
          +     0.17051094170869 * S_REP_LoyaltyTime
          +    -0.37246954594171 * S_TimeSinceLastPurchase
          +    -0.99919775556865 * S_TotalSpend ;
   H17  =     0.34936509332284 * S_AffluenceGrade  +      0.0866298939456 *
        S_CleanserProducts  +    -0.13888311618686 * S_DayCareProducts
          +     -0.4048171610832 * S_LotionProducts  +    -0.01638293440498 *
        S_NightRepairProducts  +    -0.10850034270094 * S_REP_Age
          +     0.13426139995766 * S_REP_LoyaltyTime
          +     0.01561617930046 * S_TimeSinceLastPurchase
          +     0.02616908686447 * S_TotalSpend ;
   H18  =    -0.30257117760513 * S_AffluenceGrade  +    -0.18131456418338 *
        S_CleanserProducts  +     0.05316908385883 * S_DayCareProducts
          +    -0.28400445684857 * S_LotionProducts  +    -0.28152874498206 *
        S_NightRepairProducts  +     1.38767717228215 * S_REP_Age
          +    -0.16324594456917 * S_REP_LoyaltyTime
          +     0.09233207053451 * S_TimeSinceLastPurchase
          +     0.06773112395567 * S_TotalSpend ;
   H19  =    -0.46719614970135 * S_AffluenceGrade  +     0.11836547050689 *
        S_CleanserProducts  +     -0.1345955307617 * S_DayCareProducts
          +     0.21839981582408 * S_LotionProducts  +    -0.24646593163739 *
        S_NightRepairProducts  +    -0.46977681237836 * S_REP_Age
          +    -0.03278993422102 * S_REP_LoyaltyTime
          +     0.06270183827416 * S_TimeSinceLastPurchase
          +    -0.06584651065762 * S_TotalSpend ;
   H11  = H11  +    -0.13272806855075 * CampaignViewedEmail0
          +    -0.25743476421174 * MobileApplications0
          +    -0.02197718106242 * PreviousCampaign0 ;
   H12  = H12  +    -0.06930696800823 * CampaignViewedEmail0
          +    -0.22977275089264 * MobileApplications0
          +    -0.02698701657452 * PreviousCampaign0 ;
   H13  = H13  +    -0.37410502281218 * CampaignViewedEmail0
          +     0.09528065479055 * MobileApplications0
          +     0.42997598389608 * PreviousCampaign0 ;
   H14  = H14  +    -0.00538186224245 * CampaignViewedEmail0
          +    -0.05839406909269 * MobileApplications0
          +    -0.02510983971025 * PreviousCampaign0 ;
   H15  = H15  +    -0.13041834648459 * CampaignViewedEmail0
          +    -0.38126895121144 * MobileApplications0
          +      0.6796220382511 * PreviousCampaign0 ;
   H16  = H16  +     0.27918540315213 * CampaignViewedEmail0
          +     -0.1786772330738 * MobileApplications0
          +     0.34901996231565 * PreviousCampaign0 ;
   H17  = H17  +     0.52050983596426 * CampaignViewedEmail0
          +     0.22703967944243 * MobileApplications0
          +    -0.01717104159438 * PreviousCampaign0 ;
   H18  = H18  +     0.05153234307834 * CampaignViewedEmail0
          +     0.22476412535615 * MobileApplications0
          +    -0.00836936799567 * PreviousCampaign0 ;
   H19  = H19  +     0.26841177080121 * CampaignViewedEmail0
          +     0.21028481878046 * MobileApplications0
          +      0.2741099230357 * PreviousCampaign0 ;
   H11  = H11  +    -0.20116432596589 * REP_AdvertisementZonBorder
          +     0.01402197946071 * REP_AdvertisementZonCentral_Z1
          +     -0.3797055068086 * REP_AdvertisementZonE_Central
          +    -0.32677250904431 * REP_AdvertisementZonN_Central
          +     -0.2329248146254 * REP_AdvertisementZonN_East
          +    -0.06922212782272 * REP_AdvertisementZonN_West
          +    -0.18424509091013 * REP_AdvertisementZonNE_Z1
          +      0.1004286355278 * REP_AdvertisementZonNE_Z2
          +     0.11224367263798 * REP_AdvertisementZonNE_Z3
          +     0.12718123950326 * REP_AdvertisementZonS_Central
          +     0.09136546861734 * REP_AdvertisementZonS_East
          +     0.00214655721899 * REP_AdvertisementZonS_West
          +    -0.06544147554786 * REP_AdvertisementZonU
          +     0.26020586207364 * REP_ClusterGroupA
          +     0.41317503947638 * REP_ClusterGroupB
          +    -0.02635964897463 * REP_ClusterGroupC
          +     0.15373988202289 * REP_ClusterGroupD
          +    -0.09562248102121 * REP_ClusterGroupE
          +    -0.00444628014268 * REP_ClusterGroupF
          +    -0.16153795872336 * REP_GenderF  +    -0.16905855753822 *
        REP_RegionCentral  +    -0.05446383912807 * REP_RegionNorth
          +    -0.12248886717252 * REP_RegionNorthEast
          +    -0.12308039786011 * REP_RegionSouth_East
          +    -0.14235144735797 * REP_RegionSouth_West ;
   H12  = H12  +     -0.2322755990476 * REP_AdvertisementZonBorder
          +     0.02957132160166 * REP_AdvertisementZonCentral_Z1
          +     0.04905993170399 * REP_AdvertisementZonE_Central
          +     0.02602841356628 * REP_AdvertisementZonN_Central
          +     0.04758580316173 * REP_AdvertisementZonN_East
          +     0.17749491207917 * REP_AdvertisementZonN_West
          +     0.21938987292221 * REP_AdvertisementZonNE_Z1
          +     0.14083059601308 * REP_AdvertisementZonNE_Z2
          +    -0.01756909187555 * REP_AdvertisementZonNE_Z3
          +    -0.07911985875642 * REP_AdvertisementZonS_Central
          +     0.14919392261505 * REP_AdvertisementZonS_East
          +     0.00893490988611 * REP_AdvertisementZonS_West
          +    -0.00517600710424 * REP_AdvertisementZonU
          +     0.08510733010622 * REP_ClusterGroupA
          +    -0.05592700392454 * REP_ClusterGroupB
          +    -0.20144242296389 * REP_ClusterGroupC
          +    -0.22066553061863 * REP_ClusterGroupD
          +    -0.26101722607222 * REP_ClusterGroupE
          +    -0.45800234077863 * REP_ClusterGroupF
          +    -0.39628370561558 * REP_GenderF  +     0.07127166419277 *
        REP_RegionCentral  +    -0.15783467004578 * REP_RegionNorth
          +     0.09444693456622 * REP_RegionNorthEast
          +     0.07783648938679 * REP_RegionSouth_East
          +     0.24477465673699 * REP_RegionSouth_West ;
   H13  = H13  +    -0.22306552616113 * REP_AdvertisementZonBorder
          +    -0.12086487672495 * REP_AdvertisementZonCentral_Z1
          +    -0.21069087125614 * REP_AdvertisementZonE_Central
          +     -0.0631569743545 * REP_AdvertisementZonN_Central
          +    -0.42736370191578 * REP_AdvertisementZonN_East
          +     0.16425452820356 * REP_AdvertisementZonN_West
          +     0.39212560183529 * REP_AdvertisementZonNE_Z1
          +    -0.07031389380319 * REP_AdvertisementZonNE_Z2
          +     0.22692451730476 * REP_AdvertisementZonNE_Z3
          +    -0.22283894641782 * REP_AdvertisementZonS_Central
          +     0.01209146100095 * REP_AdvertisementZonS_East
          +    -0.38017459884949 * REP_AdvertisementZonS_West
          +    -0.16354236912889 * REP_AdvertisementZonU
          +     0.04896933940994 * REP_ClusterGroupA
          +    -0.19749052697056 * REP_ClusterGroupB
          +     0.22006014037791 * REP_ClusterGroupC
          +    -0.26340570747962 * REP_ClusterGroupD
          +    -0.19497135723673 * REP_ClusterGroupE
          +    -0.27206163178552 * REP_ClusterGroupF
          +     0.58979956331668 * REP_GenderF  +    -0.21085777201816 *
        REP_RegionCentral  +     0.11585811643443 * REP_RegionNorth
          +     0.29379113840688 * REP_RegionNorthEast
          +     0.09498524188459 * REP_RegionSouth_East
          +     0.00227868482104 * REP_RegionSouth_West ;
   H14  = H14  +     0.18978076115142 * REP_AdvertisementZonBorder
          +    -0.05181518106642 * REP_AdvertisementZonCentral_Z1
          +     0.01458244382706 * REP_AdvertisementZonE_Central
          +     0.01585370253799 * REP_AdvertisementZonN_Central
          +     0.13111905770767 * REP_AdvertisementZonN_East
          +     0.04802832554828 * REP_AdvertisementZonN_West
          +    -0.00918151674646 * REP_AdvertisementZonNE_Z1
          +     -0.1619878261553 * REP_AdvertisementZonNE_Z2
          +     0.52395869503548 * REP_AdvertisementZonNE_Z3
          +    -0.88461798644099 * REP_AdvertisementZonS_Central
          +     0.19180062445711 * REP_AdvertisementZonS_East
          +    -0.21995374479066 * REP_AdvertisementZonS_West
          +    -0.15283925426431 * REP_AdvertisementZonU
          +     0.32003942757388 * REP_ClusterGroupA
          +    -0.24263480180206 * REP_ClusterGroupB
          +     0.31442467755925 * REP_ClusterGroupC
          +     0.16307798381448 * REP_ClusterGroupD
          +    -0.28840195693501 * REP_ClusterGroupE
          +     0.15427369236139 * REP_ClusterGroupF
          +    -0.56234308423332 * REP_GenderF  +    -0.30622621774345 *
        REP_RegionCentral  +     0.32104733217107 * REP_RegionNorth
          +     0.23182410609463 * REP_RegionNorthEast
          +     0.28648136918864 * REP_RegionSouth_East
          +      0.0734976382221 * REP_RegionSouth_West ;
   H15  = H15  +     0.22798371446605 * REP_AdvertisementZonBorder
          +    -0.43013259160601 * REP_AdvertisementZonCentral_Z1
          +     0.00857753280288 * REP_AdvertisementZonE_Central
          +     0.41074847941337 * REP_AdvertisementZonN_Central
          +    -0.11311117924141 * REP_AdvertisementZonN_East
          +     0.27671870813778 * REP_AdvertisementZonN_West
          +    -0.33963447796937 * REP_AdvertisementZonNE_Z1
          +     0.09025075308753 * REP_AdvertisementZonNE_Z2
          +     0.10273123040147 * REP_AdvertisementZonNE_Z3
          +    -0.29581927300964 * REP_AdvertisementZonS_Central
          +    -0.49158351990778 * REP_AdvertisementZonS_East
          +    -0.42631168603672 * REP_AdvertisementZonS_West
          +    -0.06429405153095 * REP_AdvertisementZonU
          +    -0.64137015723323 * REP_ClusterGroupA
          +    -0.16734259074736 * REP_ClusterGroupB
          +    -0.09902873881283 * REP_ClusterGroupC
          +    -0.40714290062136 * REP_ClusterGroupD
          +     0.30119245783133 * REP_ClusterGroupE
          +    -0.29507795070263 * REP_ClusterGroupF
          +    -1.10759306408333 * REP_GenderF  +    -0.17030526610004 *
        REP_RegionCentral  +     0.28001289970701 * REP_RegionNorth
          +     0.22694476545819 * REP_RegionNorthEast
          +    -0.29987002098967 * REP_RegionSouth_East
          +    -0.16176087813063 * REP_RegionSouth_West ;
   H16  = H16  +     0.11135708949996 * REP_AdvertisementZonBorder
          +    -0.11310525960306 * REP_AdvertisementZonCentral_Z1
          +    -0.15384551203138 * REP_AdvertisementZonE_Central
          +    -0.13034906749857 * REP_AdvertisementZonN_Central
          +    -0.04004386506867 * REP_AdvertisementZonN_East
          +     0.32824501916032 * REP_AdvertisementZonN_West
          +     0.10897147676055 * REP_AdvertisementZonNE_Z1
          +     0.27256477368213 * REP_AdvertisementZonNE_Z2
          +    -0.11227578942187 * REP_AdvertisementZonNE_Z3
          +    -0.18363674174596 * REP_AdvertisementZonS_Central
          +    -0.02550295546979 * REP_AdvertisementZonS_East
          +    -0.22395118564019 * REP_AdvertisementZonS_West
          +     0.17023891238594 * REP_AdvertisementZonU
          +    -0.07283230045948 * REP_ClusterGroupA
          +    -0.50701298048009 * REP_ClusterGroupB
          +    -0.28805529621488 * REP_ClusterGroupC
          +      0.0951181108841 * REP_ClusterGroupD
          +     0.01747519637534 * REP_ClusterGroupE
          +    -0.13387617642446 * REP_ClusterGroupF
          +     0.13906384548935 * REP_GenderF  +    -0.11763278227702 *
        REP_RegionCentral  +     0.08580827251895 * REP_RegionNorth
          +     0.03491390343173 * REP_RegionNorthEast
          +     0.33007324747844 * REP_RegionSouth_East
          +     0.15483332570652 * REP_RegionSouth_West ;
   H17  = H17  +     0.09897542527544 * REP_AdvertisementZonBorder
          +    -0.08679569509544 * REP_AdvertisementZonCentral_Z1
          +    -0.07490200670925 * REP_AdvertisementZonE_Central
          +    -0.05636386356912 * REP_AdvertisementZonN_Central
          +    -0.05439495876099 * REP_AdvertisementZonN_East
          +    -0.17621344797971 * REP_AdvertisementZonN_West
          +     0.21664836633842 * REP_AdvertisementZonNE_Z1
          +     0.07042023587775 * REP_AdvertisementZonNE_Z2
          +    -0.02303482483364 * REP_AdvertisementZonNE_Z3
          +     0.43806272308465 * REP_AdvertisementZonS_Central
          +     0.25726465922931 * REP_AdvertisementZonS_East
          +    -0.06132754634303 * REP_AdvertisementZonS_West
          +     0.14474673154452 * REP_AdvertisementZonU
          +    -0.14046738252541 * REP_ClusterGroupA
          +    -0.06618514366514 * REP_ClusterGroupB
          +    -0.11704428162027 * REP_ClusterGroupC
          +    -0.09652420598025 * REP_ClusterGroupD
          +     0.19534036352486 * REP_ClusterGroupE
          +     0.11262825919796 * REP_ClusterGroupF
          +    -0.09384011407309 * REP_GenderF  +    -0.10183821944705 *
        REP_RegionCentral  +    -0.09275786464794 * REP_RegionNorth
          +    -0.02269500614798 * REP_RegionNorthEast
          +    -0.56554739738517 * REP_RegionSouth_East
          +      -0.074246236796 * REP_RegionSouth_West ;
   H18  = H18  +      0.1387630401097 * REP_AdvertisementZonBorder
          +    -0.29438078754653 * REP_AdvertisementZonCentral_Z1
          +      0.2374963478351 * REP_AdvertisementZonE_Central
          +     0.08447731557957 * REP_AdvertisementZonN_Central
          +     0.22568007608793 * REP_AdvertisementZonN_East
          +     0.07668622947901 * REP_AdvertisementZonN_West
          +      0.2755732903801 * REP_AdvertisementZonNE_Z1
          +    -0.05531832634206 * REP_AdvertisementZonNE_Z2
          +     -0.2635156599058 * REP_AdvertisementZonNE_Z3
          +     0.12704086758626 * REP_AdvertisementZonS_Central
          +     0.05278512006908 * REP_AdvertisementZonS_East
          +     0.00339706014676 * REP_AdvertisementZonS_West
          +    -0.08473085826646 * REP_AdvertisementZonU
          +     0.64726234244731 * REP_ClusterGroupA
          +    -0.10500831020476 * REP_ClusterGroupB
          +    -0.32028755194428 * REP_ClusterGroupC
          +     0.69675814579946 * REP_ClusterGroupD
          +    -0.06189231688666 * REP_ClusterGroupE
          +    -0.24449836031066 * REP_ClusterGroupF
          +    -0.08605651975103 * REP_GenderF  +     0.35581462440361 *
        REP_RegionCentral  +     0.17170697585204 * REP_RegionNorth
          +      0.0485242498493 * REP_RegionNorthEast
          +     0.61379015239068 * REP_RegionSouth_East
          +    -0.37543644540114 * REP_RegionSouth_West ;
   H19  = H19  +    -0.01579536369251 * REP_AdvertisementZonBorder
          +    -0.05091079174818 * REP_AdvertisementZonCentral_Z1
          +     0.04799734107076 * REP_AdvertisementZonE_Central
          +    -0.04876703558083 * REP_AdvertisementZonN_Central
          +     -0.0055072943483 * REP_AdvertisementZonN_East
          +    -0.09883055213145 * REP_AdvertisementZonN_West
          +    -0.12363397739936 * REP_AdvertisementZonNE_Z1
          +     0.16764153512305 * REP_AdvertisementZonNE_Z2
          +     -0.4114347113126 * REP_AdvertisementZonNE_Z3
          +     0.14789585614694 * REP_AdvertisementZonS_Central
          +    -0.04927231393395 * REP_AdvertisementZonS_East
          +     0.12560517952337 * REP_AdvertisementZonS_West
          +    -0.00338477826572 * REP_AdvertisementZonU
          +      0.0785316473472 * REP_ClusterGroupA
          +    -0.03366557838979 * REP_ClusterGroupB
          +    -0.13581768438039 * REP_ClusterGroupC
          +     0.32761531171485 * REP_ClusterGroupD
          +     0.28006529699829 * REP_ClusterGroupE
          +    -0.13339906135744 * REP_ClusterGroupF
          +    -0.15376466311658 * REP_GenderF  +     0.19268854114692 *
        REP_RegionCentral  +    -0.60276683406535 * REP_RegionNorth
          +     0.17269126035314 * REP_RegionNorthEast
          +     0.11343316985109 * REP_RegionSouth_East
          +    -0.15752232046067 * REP_RegionSouth_West ;
   H11  =    -1.14468295095347 + H11 ;
   H12  =    -0.42202383487249 + H12 ;
   H13  =     0.75341748148465 + H13 ;
   H14  =    -0.84369306590345 + H14 ;
   H15  =    -0.99832997604406 + H15 ;
   H16  =     0.60972022607002 + H16 ;
   H17  =    -1.05722426375891 + H17 ;
   H18  =     1.50699109469782 + H18 ;
   H19  =      1.6312630239631 + H19 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
   H14  = TANH(H14 );
   H15  = TANH(H15 );
   H16  = TANH(H16 );
   H17  = TANH(H17 );
   H18  = TANH(H18 );
   H19  = TANH(H19 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
   H14  = .;
   H15  = .;
   H16  = .;
   H17  = .;
   H18  = .;
   H19  = .;
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
   P_TargetBuy1  =     0.71662819427971 * H11  +    -0.21625641452141 * H12
          +    -0.84657985495995 * H13  +    -1.64946229660994 * H14
          +    -2.07674058223391 * H15  +     0.71419723690897 * H16
          +    -0.76723133757625 * H17  +     -1.7785008182293 * H18
          +    -0.92723878243912 * H19 ;
   P_TargetBuy1  =    -1.77367878867431 + P_TargetBuy1 ;
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
   P_TargetBuy1  =     0.23628219484882;
   P_TargetBuy0  =     0.76371780515117;
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
