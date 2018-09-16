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
      label S_IMP_DemAffl = 'Standard: IMP_DemAffl' ;

      label S_IMP_DemAge = 'Standard: IMP_DemAge' ;

      label S_IMP_PromTime = 'Standard: IMP_PromTime' ;

      label S_PromSpend = 'Standard: PromSpend' ;

      label M_DemAffl0 = 'Dummy: M_DemAffl=0' ;

      label M_DemAge0 = 'Dummy: M_DemAge=0' ;

      label M_DemClusterGroup0 = 'Dummy: M_DemClusterGroup=0' ;

      label M_DemGender0 = 'Dummy: M_DemGender=0' ;

      label M_DemReg0 = 'Dummy: M_DemReg=0' ;

      label M_DemTVReg0 = 'Dummy: M_DemTVReg=0' ;

      label M_PromTime0 = 'Dummy: M_PromTime=0' ;

      label IMP_DemClusterGroupA = 'Dummy: IMP_DemClusterGroup=A' ;

      label IMP_DemClusterGroupB = 'Dummy: IMP_DemClusterGroup=B' ;

      label IMP_DemClusterGroupC = 'Dummy: IMP_DemClusterGroup=C' ;

      label IMP_DemClusterGroupD = 'Dummy: IMP_DemClusterGroup=D' ;

      label IMP_DemClusterGroupE = 'Dummy: IMP_DemClusterGroup=E' ;

      label IMP_DemClusterGroupF = 'Dummy: IMP_DemClusterGroup=F' ;

      label IMP_DemGenderF = 'Dummy: IMP_DemGender=F' ;

      label IMP_DemGenderM = 'Dummy: IMP_DemGender=M' ;

      label IMP_DemRegMidlands = 'Dummy: IMP_DemReg=Midlands' ;

      label IMP_DemRegNorth = 'Dummy: IMP_DemReg=North' ;

      label IMP_DemRegScottish = 'Dummy: IMP_DemReg=Scottish' ;

      label IMP_DemRegSouth_East = 'Dummy: IMP_DemReg=South East' ;

      label IMP_DemTVRegBorder = 'Dummy: IMP_DemTVReg=Border' ;

      label IMP_DemTVRegC_Scotland = 'Dummy: IMP_DemTVReg=C Scotland' ;

      label IMP_DemTVRegEast = 'Dummy: IMP_DemTVReg=East' ;

      label IMP_DemTVRegLondon = 'Dummy: IMP_DemTVReg=London' ;

      label IMP_DemTVRegMidlands = 'Dummy: IMP_DemTVReg=Midlands' ;

      label IMP_DemTVRegN_East = 'Dummy: IMP_DemTVReg=N East' ;

      label IMP_DemTVRegN_Scot = 'Dummy: IMP_DemTVReg=N Scot' ;

      label IMP_DemTVRegN_West = 'Dummy: IMP_DemTVReg=N West' ;

      label IMP_DemTVRegS___S_East = 'Dummy: IMP_DemTVReg=S & S East' ;

      label IMP_DemTVRegS_West = 'Dummy: IMP_DemTVReg=S West' ;

      label IMP_DemTVRegUlster = 'Dummy: IMP_DemTVReg=Ulster' ;

      label IMP_DemTVRegWales___West = 'Dummy: IMP_DemTVReg=Wales & West' ;

      label PromClassGold = 'Dummy: PromClass=Gold' ;

      label PromClassPlatinum = 'Dummy: PromClass=Platinum' ;

      label PromClassSilver = 'Dummy: PromClass=Silver' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label I_TargetBuy = 'Into: TargetBuy' ;

      label F_TargetBuy = 'From: TargetBuy' ;

      label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;

      label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;

      label R_TargetBuy1 = 'Residual: TargetBuy=1' ;

      label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;

      label R_TargetBuy0 = 'Residual: TargetBuy=0' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for M_DemAffl ;
drop M_DemAffl0 ;
if missing( M_DemAffl ) then do;
   M_DemAffl0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemAffl , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemAffl0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemAffl0 = -1;
   end;
   else do;
      M_DemAffl0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemAge ;
drop M_DemAge0 ;
if missing( M_DemAge ) then do;
   M_DemAge0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemAge , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemAge0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemAge0 = -1;
   end;
   else do;
      M_DemAge0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemClusterGroup ;
drop M_DemClusterGroup0 ;
if missing( M_DemClusterGroup ) then do;
   M_DemClusterGroup0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemClusterGroup , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemClusterGroup0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemClusterGroup0 = -1;
   end;
   else do;
      M_DemClusterGroup0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemGender ;
drop M_DemGender0 ;
if missing( M_DemGender ) then do;
   M_DemGender0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemGender , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemGender0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemGender0 = -1;
   end;
   else do;
      M_DemGender0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemReg ;
drop M_DemReg0 ;
if missing( M_DemReg ) then do;
   M_DemReg0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemReg , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemReg0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemReg0 = -1;
   end;
   else do;
      M_DemReg0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_DemTVReg ;
drop M_DemTVReg0 ;
if missing( M_DemTVReg ) then do;
   M_DemTVReg0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_DemTVReg , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_DemTVReg0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_DemTVReg0 = -1;
   end;
   else do;
      M_DemTVReg0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for M_PromTime ;
drop M_PromTime0 ;
if missing( M_PromTime ) then do;
   M_PromTime0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( M_PromTime , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '0'  then do;
      M_PromTime0 = 1;
   end;
   else if _dm12 = '1'  then do;
      M_PromTime0 = -1;
   end;
   else do;
      M_PromTime0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_DemClusterGroup ;
drop IMP_DemClusterGroupA IMP_DemClusterGroupB IMP_DemClusterGroupC
        IMP_DemClusterGroupD IMP_DemClusterGroupE IMP_DemClusterGroupF ;
*** encoding is sparse, initialize to zero;
IMP_DemClusterGroupA = 0;
IMP_DemClusterGroupB = 0;
IMP_DemClusterGroupC = 0;
IMP_DemClusterGroupD = 0;
IMP_DemClusterGroupE = 0;
IMP_DemClusterGroupF = 0;
if missing( IMP_DemClusterGroup ) then do;
   IMP_DemClusterGroupA = .;
   IMP_DemClusterGroupB = .;
   IMP_DemClusterGroupC = .;
   IMP_DemClusterGroupD = .;
   IMP_DemClusterGroupE = .;
   IMP_DemClusterGroupF = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   %DMNORMCP( IMP_DemClusterGroup , _dm1 )
   _dm_find = 0; drop _dm_find;
   if _dm1 <= 'D'  then do;
      if _dm1 <= 'B'  then do;
         if _dm1 = 'A'  then do;
            IMP_DemClusterGroupA = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'B'  then do;
               IMP_DemClusterGroupB = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'C'  then do;
            IMP_DemClusterGroupC = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'D'  then do;
               IMP_DemClusterGroupD = 1;
               _dm_find = 1;
            end;
         end;
      end;
   end;
   else do;
      if _dm1 <= 'F'  then do;
         if _dm1 = 'E'  then do;
            IMP_DemClusterGroupE = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm1 = 'F'  then do;
               IMP_DemClusterGroupF = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm1 = 'U'  then do;
            IMP_DemClusterGroupA = -1;
            IMP_DemClusterGroupB = -1;
            IMP_DemClusterGroupC = -1;
            IMP_DemClusterGroupD = -1;
            IMP_DemClusterGroupE = -1;
            IMP_DemClusterGroupF = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_DemClusterGroupA = .;
      IMP_DemClusterGroupB = .;
      IMP_DemClusterGroupC = .;
      IMP_DemClusterGroupD = .;
      IMP_DemClusterGroupE = .;
      IMP_DemClusterGroupF = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_DemGender ;
drop IMP_DemGenderF IMP_DemGenderM ;
if missing( IMP_DemGender ) then do;
   IMP_DemGenderF = .;
   IMP_DemGenderM = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm1 $ 1; drop _dm1 ;
   %DMNORMCP( IMP_DemGender , _dm1 )
   if _dm1 = 'F'  then do;
      IMP_DemGenderF = 1;
      IMP_DemGenderM = 0;
   end;
   else if _dm1 = 'M'  then do;
      IMP_DemGenderF = 0;
      IMP_DemGenderM = 1;
   end;
   else if _dm1 = 'U'  then do;
      IMP_DemGenderF = -1;
      IMP_DemGenderM = -1;
   end;
   else do;
      IMP_DemGenderF = .;
      IMP_DemGenderM = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_DemReg ;
drop IMP_DemRegMidlands IMP_DemRegNorth IMP_DemRegScottish
        IMP_DemRegSouth_East ;
*** encoding is sparse, initialize to zero;
IMP_DemRegMidlands = 0;
IMP_DemRegNorth = 0;
IMP_DemRegScottish = 0;
IMP_DemRegSouth_East = 0;
if missing( IMP_DemReg ) then do;
   IMP_DemRegMidlands = .;
   IMP_DemRegNorth = .;
   IMP_DemRegScottish = .;
   IMP_DemRegSouth_East = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   %DMNORMCP( IMP_DemReg , _dm10 )
   _dm_find = 0; drop _dm_find;
   if _dm10 <= 'SCOTTISH'  then do;
      if _dm10 <= 'NORTH'  then do;
         if _dm10 = 'MIDLANDS'  then do;
            IMP_DemRegMidlands = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'NORTH'  then do;
               IMP_DemRegNorth = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'SCOTTISH'  then do;
            IMP_DemRegScottish = 1;
            _dm_find = 1;
         end;
      end;
   end;
   else do;
      if _dm10 = 'SOUTH EAST'  then do;
         IMP_DemRegSouth_East = 1;
         _dm_find = 1;
      end;
      else do;
         if _dm10 = 'SOUTH WEST'  then do;
            IMP_DemRegMidlands = -1;
            IMP_DemRegNorth = -1;
            IMP_DemRegScottish = -1;
            IMP_DemRegSouth_East = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_DemRegMidlands = .;
      IMP_DemRegNorth = .;
      IMP_DemRegScottish = .;
      IMP_DemRegSouth_East = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_DemTVReg ;
drop IMP_DemTVRegBorder IMP_DemTVRegC_Scotland IMP_DemTVRegEast
        IMP_DemTVRegLondon IMP_DemTVRegMidlands IMP_DemTVRegN_East
        IMP_DemTVRegN_Scot IMP_DemTVRegN_West IMP_DemTVRegS___S_East
        IMP_DemTVRegS_West IMP_DemTVRegUlster IMP_DemTVRegWales___West ;
*** encoding is sparse, initialize to zero;
IMP_DemTVRegBorder = 0;
IMP_DemTVRegC_Scotland = 0;
IMP_DemTVRegEast = 0;
IMP_DemTVRegLondon = 0;
IMP_DemTVRegMidlands = 0;
IMP_DemTVRegN_East = 0;
IMP_DemTVRegN_Scot = 0;
IMP_DemTVRegN_West = 0;
IMP_DemTVRegS___S_East = 0;
IMP_DemTVRegS_West = 0;
IMP_DemTVRegUlster = 0;
IMP_DemTVRegWales___West = 0;
if missing( IMP_DemTVReg ) then do;
   IMP_DemTVRegBorder = .;
   IMP_DemTVRegC_Scotland = .;
   IMP_DemTVRegEast = .;
   IMP_DemTVRegLondon = .;
   IMP_DemTVRegMidlands = .;
   IMP_DemTVRegN_East = .;
   IMP_DemTVRegN_Scot = .;
   IMP_DemTVRegN_West = .;
   IMP_DemTVRegS___S_East = .;
   IMP_DemTVRegS_West = .;
   IMP_DemTVRegUlster = .;
   IMP_DemTVRegWales___West = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   %DMNORMCP( IMP_DemTVReg , _dm12 )
   if _dm12 = 'LONDON'  then do;
      IMP_DemTVRegLondon = 1;
   end;
   else if _dm12 = 'MIDLANDS'  then do;
      IMP_DemTVRegMidlands = 1;
   end;
   else if _dm12 = 'S & S EAST'  then do;
      IMP_DemTVRegS___S_East = 1;
   end;
   else if _dm12 = 'N WEST'  then do;
      IMP_DemTVRegN_West = 1;
   end;
   else if _dm12 = 'EAST'  then do;
      IMP_DemTVRegEast = 1;
   end;
   else if _dm12 = 'WALES & WEST'  then do;
      IMP_DemTVRegWales___West = 1;
   end;
   else if _dm12 = 'YORKSHIRE'  then do;
      IMP_DemTVRegBorder = -1;
      IMP_DemTVRegC_Scotland = -1;
      IMP_DemTVRegEast = -1;
      IMP_DemTVRegLondon = -1;
      IMP_DemTVRegMidlands = -1;
      IMP_DemTVRegN_East = -1;
      IMP_DemTVRegN_Scot = -1;
      IMP_DemTVRegN_West = -1;
      IMP_DemTVRegS___S_East = -1;
      IMP_DemTVRegS_West = -1;
      IMP_DemTVRegUlster = -1;
      IMP_DemTVRegWales___West = -1;
   end;
   else if _dm12 = 'C SCOTLAND'  then do;
      IMP_DemTVRegC_Scotland = 1;
   end;
   else if _dm12 = 'N EAST'  then do;
      IMP_DemTVRegN_East = 1;
   end;
   else if _dm12 = 'S WEST'  then do;
      IMP_DemTVRegS_West = 1;
   end;
   else if _dm12 = 'N SCOT'  then do;
      IMP_DemTVRegN_Scot = 1;
   end;
   else if _dm12 = 'ULSTER'  then do;
      IMP_DemTVRegUlster = 1;
   end;
   else if _dm12 = 'BORDER'  then do;
      IMP_DemTVRegBorder = 1;
   end;
   else do;
      IMP_DemTVRegBorder = .;
      IMP_DemTVRegC_Scotland = .;
      IMP_DemTVRegEast = .;
      IMP_DemTVRegLondon = .;
      IMP_DemTVRegMidlands = .;
      IMP_DemTVRegN_East = .;
      IMP_DemTVRegN_Scot = .;
      IMP_DemTVRegN_West = .;
      IMP_DemTVRegS___S_East = .;
      IMP_DemTVRegS_West = .;
      IMP_DemTVRegUlster = .;
      IMP_DemTVRegWales___West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for PromClass ;
drop PromClassGold PromClassPlatinum PromClassSilver ;
if missing( PromClass ) then do;
   PromClassGold = .;
   PromClassPlatinum = .;
   PromClassSilver = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm8 $ 8; drop _dm8 ;
   %DMNORMCP( PromClass , _dm8 )
   if _dm8 = 'SILVER'  then do;
      PromClassGold = 0;
      PromClassPlatinum = 0;
      PromClassSilver = 1;
   end;
   else if _dm8 = 'TIN'  then do;
      PromClassGold = -1;
      PromClassPlatinum = -1;
      PromClassSilver = -1;
   end;
   else if _dm8 = 'GOLD'  then do;
      PromClassGold = 1;
      PromClassPlatinum = 0;
      PromClassSilver = 0;
   end;
   else if _dm8 = 'PLATINUM'  then do;
      PromClassGold = 0;
      PromClassPlatinum = 1;
      PromClassSilver = 0;
   end;
   else do;
      PromClassGold = .;
      PromClassPlatinum = .;
      PromClassSilver = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   IMP_DemAffl ,
   IMP_DemAge ,
   IMP_PromTime ,
   PromSpend   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_IMP_DemAffl  =    -2.60457990739599 +     0.29927270189172 * IMP_DemAffl
         ;
   S_IMP_DemAge  =    -4.23142348417316 +     0.07851658867769 * IMP_DemAge ;
   S_IMP_PromTime  =    -1.41730026199246 +      0.2156880882318 *
        IMP_PromTime ;
   S_PromSpend  =    -0.63590727995162 +     0.00014432319817 * PromSpend ;
END;
ELSE DO;
   IF MISSING( IMP_DemAffl ) THEN S_IMP_DemAffl  = . ;
   ELSE S_IMP_DemAffl  =    -2.60457990739599 +     0.29927270189172 *
        IMP_DemAffl ;
   IF MISSING( IMP_DemAge ) THEN S_IMP_DemAge  = . ;
   ELSE S_IMP_DemAge  =    -4.23142348417316 +     0.07851658867769 *
        IMP_DemAge ;
   IF MISSING( IMP_PromTime ) THEN S_IMP_PromTime  = . ;
   ELSE S_IMP_PromTime  =    -1.41730026199246 +      0.2156880882318 *
        IMP_PromTime ;
   IF MISSING( PromSpend ) THEN S_PromSpend  = . ;
   ELSE S_PromSpend  =    -0.63590727995162 +     0.00014432319817 * PromSpend
         ;
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
   H11  =     0.27302695794721 * S_IMP_DemAffl  +    -1.72008565598321 *
        S_IMP_DemAge  +    -0.03670799983204 * S_IMP_PromTime
          +    -0.08351836806814 * S_PromSpend ;
   H12  =    -0.55516417525726 * S_IMP_DemAffl  +    -0.33842751262655 *
        S_IMP_DemAge  +    -0.18076796504858 * S_IMP_PromTime
          +     0.09048900938635 * S_PromSpend ;
   H13  =    -0.35487765440194 * S_IMP_DemAffl  +     0.00694812385045 *
        S_IMP_DemAge  +     0.17658961177194 * S_IMP_PromTime
          +     0.00728793012364 * S_PromSpend ;
   H11  = H11  +    -0.07765679313485 * M_DemAffl0  +    -0.14454815332085 *
        M_DemAge0  +    -0.07288821310207 * M_DemClusterGroup0
          +    -0.01608862304269 * M_DemGender0  +     0.09586952191964 *
        M_DemReg0  +    -0.15333029579836 * M_DemTVReg0
          +    -0.08149935809838 * M_PromTime0 ;
   H12  = H12  +     0.09697312560078 * M_DemAffl0  +     0.19814872324515 *
        M_DemAge0  +     0.11570014537869 * M_DemClusterGroup0
          +    -0.41336183353109 * M_DemGender0  +    -0.08257093172583 *
        M_DemReg0  +    -0.05626797168196 * M_DemTVReg0
          +    -0.25990694557529 * M_PromTime0 ;
   H13  = H13  +     0.06466984424154 * M_DemAffl0  +     0.30420272434875 *
        M_DemAge0  +    -0.20290095264451 * M_DemClusterGroup0
          +    -0.60676997029973 * M_DemGender0  +      0.1830063474891 *
        M_DemReg0  +    -0.04616333975427 * M_DemTVReg0
          +     0.22934833662321 * M_PromTime0 ;
   H11  = H11  +    -0.11175414448024 * IMP_DemClusterGroupA
          +    -0.08017219789681 * IMP_DemClusterGroupB
          +    -0.17991449388584 * IMP_DemClusterGroupC
          +     0.14284070176203 * IMP_DemClusterGroupD
          +     0.01942309474716 * IMP_DemClusterGroupE
          +    -0.06031590029809 * IMP_DemClusterGroupF
          +     0.11005787744549 * IMP_DemGenderF  +     0.01583011319613 *
        IMP_DemGenderM  +     0.08854872785325 * IMP_DemRegMidlands
          +     0.10813776485316 * IMP_DemRegNorth  +     0.24902103206541 *
        IMP_DemRegScottish  +     0.12011538547047 * IMP_DemRegSouth_East
          +    -0.14234286382981 * IMP_DemTVRegBorder
          +     -0.0488295481403 * IMP_DemTVRegC_Scotland
          +    -0.03633770237688 * IMP_DemTVRegEast  +     0.08582074010346 *
        IMP_DemTVRegLondon  +     0.14354055568152 * IMP_DemTVRegMidlands
          +     0.07394969828683 * IMP_DemTVRegN_East
          +     0.12724137621586 * IMP_DemTVRegN_Scot
          +    -0.14959012538213 * IMP_DemTVRegN_West
          +     0.10927423401474 * IMP_DemTVRegS___S_East
          +    -0.00153896516969 * IMP_DemTVRegS_West
          +    -0.12588287642119 * IMP_DemTVRegUlster
          +     0.13782299537365 * IMP_DemTVRegWales___West
          +     -0.0696348324328 * PromClassGold  +      0.1490631162031 *
        PromClassPlatinum  +    -0.09940494725654 * PromClassSilver ;
   H12  = H12  +    -0.14498880031313 * IMP_DemClusterGroupA
          +     -0.1537771127008 * IMP_DemClusterGroupB
          +    -0.08906135652334 * IMP_DemClusterGroupC
          +     0.15005643493399 * IMP_DemClusterGroupD
          +     0.03251507528785 * IMP_DemClusterGroupE
          +    -0.00020442727755 * IMP_DemClusterGroupF
          +    -0.53898254610819 * IMP_DemGenderF  +     0.07677685056982 *
        IMP_DemGenderM  +      -0.021609046665 * IMP_DemRegMidlands
          +     0.04175720418523 * IMP_DemRegNorth  +     -0.1007414647824 *
        IMP_DemRegScottish  +    -0.04064747107387 * IMP_DemRegSouth_East
          +      0.1000523102195 * IMP_DemTVRegBorder
          +    -0.15625470446411 * IMP_DemTVRegC_Scotland
          +    -0.17322455405055 * IMP_DemTVRegEast  +     0.10379517208997 *
        IMP_DemTVRegLondon  +     0.11612761744546 * IMP_DemTVRegMidlands
          +    -0.09808740430313 * IMP_DemTVRegN_East
          +     0.01225471095272 * IMP_DemTVRegN_Scot
          +    -0.04307739083411 * IMP_DemTVRegN_West
          +     0.18142087032071 * IMP_DemTVRegS___S_East
          +    -0.25149025879538 * IMP_DemTVRegS_West
          +     0.09661780937358 * IMP_DemTVRegUlster
          +    -0.23454344949079 * IMP_DemTVRegWales___West
          +     0.11345705707889 * PromClassGold  +     0.19103805491297 *
        PromClassPlatinum  +    -0.01603564799614 * PromClassSilver ;
   H13  = H13  +     0.17141639460708 * IMP_DemClusterGroupA
          +     0.01437820589631 * IMP_DemClusterGroupB
          +    -0.08518752646624 * IMP_DemClusterGroupC
          +    -0.05849646191775 * IMP_DemClusterGroupD
          +     0.12397525436951 * IMP_DemClusterGroupE
          +     0.04891293267255 * IMP_DemClusterGroupF
          +    -0.64301583105525 * IMP_DemGenderF  +    -0.19119048629576 *
        IMP_DemGenderM  +     0.12062292926989 * IMP_DemRegMidlands
          +     0.11004704694203 * IMP_DemRegNorth  +     0.13836309976855 *
        IMP_DemRegScottish  +    -0.03995438611929 * IMP_DemRegSouth_East
          +     0.05264516441216 * IMP_DemTVRegBorder
          +     0.02754965047542 * IMP_DemTVRegC_Scotland
          +     0.02737918040781 * IMP_DemTVRegEast  +      -0.036667185051 *
        IMP_DemTVRegLondon  +    -0.08600862641018 * IMP_DemTVRegMidlands
          +    -0.09747370402179 * IMP_DemTVRegN_East
          +     0.12326759975481 * IMP_DemTVRegN_Scot
          +     0.02306896797027 * IMP_DemTVRegN_West
          +     0.16270693659287 * IMP_DemTVRegS___S_East
          +    -0.02990902361897 * IMP_DemTVRegS_West
          +     0.22548212817132 * IMP_DemTVRegUlster
          +     0.02266656458886 * IMP_DemTVRegWales___West
          +    -0.25351206170676 * PromClassGold  +    -0.25659516418153 *
        PromClassPlatinum  +      0.1502591772307 * PromClassSilver ;
   H11  =    -1.18645452298259 + H11 ;
   H12  =     1.33041454235164 + H12 ;
   H13  =     0.22114551764411 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
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
   P_TargetBuy1  =     1.49239041810177 * H11  +    -1.19512509671414 * H12
          +    -1.02432502647054 * H13 ;
   P_TargetBuy1  =    -0.28150281423695 + P_TargetBuy1 ;
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
   P_TargetBuy1  =      0.2477501799856;
   P_TargetBuy0  =     0.75224982001439;
END;
*** *****************************;
*** Writing the Residuals  of the Node TargetBuy ;
*** ******************************;
IF MISSING( TargetBuy1 ) THEN R_TargetBuy1  = . ;
ELSE R_TargetBuy1  = TargetBuy1  - P_TargetBuy1 ;
IF MISSING( TargetBuy0 ) THEN R_TargetBuy0  = . ;
ELSE R_TargetBuy0  = TargetBuy0  - P_TargetBuy0 ;


*** Decision Processing;
label D_TARGETBUY = 'Decision: TargetBuy' ;
label EP_TARGETBUY = 'Expected Profit: TargetBuy' ;
label BP_TARGETBUY = 'Best Profit: TargetBuy' ;
label CP_TARGETBUY = 'Computed Profit: TargetBuy' ;

length D_TARGETBUY $ 7;

D_TARGETBUY = ' ';
EP_TARGETBUY = .;
BP_TARGETBUY = .;
CP_TARGETBUY = .;

*** Compute Expected Consequences and Choose Decision;
_decnum = 1; drop _decnum;

D_TARGETBUY = '1' ;
EP_TARGETBUY = P_TargetBuy1 * 15 + P_TargetBuy0 * -0.5;
drop _sum;
_sum = P_TargetBuy1 * 0 + P_TargetBuy0 * 0;
if _sum > EP_TARGETBUY + 6.82121E-12 then do;
   EP_TARGETBUY = _sum; _decnum = 2;
   D_TARGETBUY = '0' ;
end;

*** Decision Matrix;
array NEURALdema [2,2] _temporary_ (
/* row 1 */  15 0
/* row 2 */  -0.5 0
);

*** Find Index of Target Category;
drop _tarnum; select( F_TargetBuy );
   when('1' ) _tarnum = 1;
   when('0' ) _tarnum = 2;
   otherwise _tarnum = 0;
end;
if _tarnum <= 0 then goto NEURALdeex;

*** Computed Consequence of Chosen Decision;
CP_TARGETBUY = NEURALdema [_tarnum,_decnum];

*** Best Possible Consequence of Any Decision without Cost;
array NEURALdebe [2] _temporary_ ( 15 0);
BP_TARGETBUY = NEURALdebe [_tarnum];


NEURALdeex:;

*** End Decision Processing ;
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
drop
S_IMP_DemAffl
S_IMP_DemAge
S_IMP_PromTime
S_PromSpend
H11
H12
H13
;
