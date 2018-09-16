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

      label IMP_DemRegSouth_West = 'Dummy: IMP_DemReg=South West' ;

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

      label IMP_DemTVRegU = 'Dummy: IMP_DemTVReg=U' ;

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
        IMP_DemRegSouth_East IMP_DemRegSouth_West ;
*** encoding is sparse, initialize to zero;
IMP_DemRegMidlands = 0;
IMP_DemRegNorth = 0;
IMP_DemRegScottish = 0;
IMP_DemRegSouth_East = 0;
IMP_DemRegSouth_West = 0;
if missing( IMP_DemReg ) then do;
   IMP_DemRegMidlands = .;
   IMP_DemRegNorth = .;
   IMP_DemRegScottish = .;
   IMP_DemRegSouth_East = .;
   IMP_DemRegSouth_West = .;
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
      if _dm10 <= 'SOUTH WEST'  then do;
         if _dm10 = 'SOUTH EAST'  then do;
            IMP_DemRegSouth_East = 1;
            _dm_find = 1;
         end;
         else do;
            if _dm10 = 'SOUTH WEST'  then do;
               IMP_DemRegSouth_West = 1;
               _dm_find = 1;
            end;
         end;
      end;
      else do;
         if _dm10 = 'U'  then do;
            IMP_DemRegMidlands = -1;
            IMP_DemRegNorth = -1;
            IMP_DemRegScottish = -1;
            IMP_DemRegSouth_East = -1;
            IMP_DemRegSouth_West = -1;
            _dm_find = 1;
         end;
      end;
   end;
   if not _dm_find then do;
      IMP_DemRegMidlands = .;
      IMP_DemRegNorth = .;
      IMP_DemRegScottish = .;
      IMP_DemRegSouth_East = .;
      IMP_DemRegSouth_West = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for IMP_DemTVReg ;
drop IMP_DemTVRegBorder IMP_DemTVRegC_Scotland IMP_DemTVRegEast
        IMP_DemTVRegLondon IMP_DemTVRegMidlands IMP_DemTVRegN_East
        IMP_DemTVRegN_Scot IMP_DemTVRegN_West IMP_DemTVRegS___S_East
        IMP_DemTVRegS_West IMP_DemTVRegU IMP_DemTVRegUlster
        IMP_DemTVRegWales___West ;
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
IMP_DemTVRegU = 0;
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
   IMP_DemTVRegU = .;
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
      IMP_DemTVRegU = -1;
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
   else if _dm12 = 'U'  then do;
      IMP_DemTVRegU = 1;
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
      IMP_DemTVRegU = .;
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
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     0.33514164021243 * S_IMP_DemAffl  +     0.11596621573519 *
        S_IMP_DemAge  +      0.0193762232414 * S_IMP_PromTime
          +    -0.00526492026798 * S_PromSpend ;
   H12  =    -0.86939499058009 * S_IMP_DemAffl  +    -0.26053524204981 *
        S_IMP_DemAge  +     0.09505919536532 * S_IMP_PromTime
          +    -0.02186483691292 * S_PromSpend ;
   H13  =    -0.23280207322026 * S_IMP_DemAffl  +     1.90579296333453 *
        S_IMP_DemAge  +     0.04211088338456 * S_IMP_PromTime
          +      0.0435007184998 * S_PromSpend ;
   H11  = H11  +    -0.07185862831109 * IMP_DemClusterGroupA
          +     0.14209992846769 * IMP_DemClusterGroupB
          +     0.05512345102904 * IMP_DemClusterGroupC
          +     0.00876265730612 * IMP_DemClusterGroupD
          +     0.01078864014415 * IMP_DemClusterGroupE
          +    -0.02305571585614 * IMP_DemClusterGroupF
          +     0.48929754128141 * IMP_DemGenderF  +    -0.02083397373017 *
        IMP_DemGenderM  +     0.07450419622443 * IMP_DemRegMidlands
          +    -0.05970641466803 * IMP_DemRegNorth  +    -0.02366445609947 *
        IMP_DemRegScottish  +     0.01498175232516 * IMP_DemRegSouth_East
          +      0.1931427163831 * IMP_DemRegSouth_West
          +     -0.3040987860366 * IMP_DemTVRegBorder
          +      0.0433623337414 * IMP_DemTVRegC_Scotland
          +     0.00677972376793 * IMP_DemTVRegEast  +     0.12445879655791 *
        IMP_DemTVRegLondon  +    -0.12336451725983 * IMP_DemTVRegMidlands
          +    -0.00906627806701 * IMP_DemTVRegN_East
          +     0.01162004804296 * IMP_DemTVRegN_Scot
          +     0.09796962360466 * IMP_DemTVRegN_West
          +    -0.13680504968457 * IMP_DemTVRegS___S_East
          +     -0.0185933975581 * IMP_DemTVRegS_West
          +     0.17982716175851 * IMP_DemTVRegU  +    -0.07607896125103 *
        IMP_DemTVRegUlster  +    -0.01051766659084 * IMP_DemTVRegWales___West
          +     0.10335733830778 * PromClassGold  +      -0.134276912515 *
        PromClassPlatinum  +     0.04043042109472 * PromClassSilver ;
   H12  = H12  +    -0.02191800371384 * IMP_DemClusterGroupA
          +     0.20743710498565 * IMP_DemClusterGroupB
          +    -0.14248893122474 * IMP_DemClusterGroupC
          +     0.09039642274921 * IMP_DemClusterGroupD
          +    -0.14632637551079 * IMP_DemClusterGroupE
          +    -0.16449401196651 * IMP_DemClusterGroupF
          +      -0.405503757677 * IMP_DemGenderF  +    -0.03681461873073 *
        IMP_DemGenderM  +     0.16704311593254 * IMP_DemRegMidlands
          +     0.05175768311786 * IMP_DemRegNorth  +    -0.07586851764268 *
        IMP_DemRegScottish  +     0.14439456035495 * IMP_DemRegSouth_East
          +    -0.16587926686786 * IMP_DemRegSouth_West
          +    -0.08141493477465 * IMP_DemTVRegBorder
          +    -0.12486235199566 * IMP_DemTVRegC_Scotland
          +      0.1586434818329 * IMP_DemTVRegEast  +     0.05481559156326 *
        IMP_DemTVRegLondon  +    -0.00324242301934 * IMP_DemTVRegMidlands
          +    -0.32861155445801 * IMP_DemTVRegN_East
          +    -0.03729852405263 * IMP_DemTVRegN_Scot
          +    -0.01785639447981 * IMP_DemTVRegN_West
          +    -0.01548585110543 * IMP_DemTVRegS___S_East
          +    -0.02644884927729 * IMP_DemTVRegS_West
          +     0.13665003538523 * IMP_DemTVRegU  +    -0.09639503942035 *
        IMP_DemTVRegUlster  +    -0.36710621308338 * IMP_DemTVRegWales___West
          +     0.11401368884999 * PromClassGold  +     0.05311680368144 *
        PromClassPlatinum  +     0.00397940381369 * PromClassSilver ;
   H13  = H13  +    -0.07128269656593 * IMP_DemClusterGroupA
          +      0.1458139691695 * IMP_DemClusterGroupB
          +     0.17559560718879 * IMP_DemClusterGroupC
          +    -0.12809405170111 * IMP_DemClusterGroupD
          +     0.09270106900686 * IMP_DemClusterGroupE
          +     0.08993038213279 * IMP_DemClusterGroupF
          +     0.08370603808949 * IMP_DemGenderF  +     0.02520687134155 *
        IMP_DemGenderM  +    -0.04312895833653 * IMP_DemRegMidlands
          +     0.13278600519003 * IMP_DemRegNorth  +     0.10636448667079 *
        IMP_DemRegScottish  +     -0.0042627405221 * IMP_DemRegSouth_East
          +     0.26158650406481 * IMP_DemRegSouth_West
          +    -0.08677326788284 * IMP_DemTVRegBorder
          +    -0.17422516254782 * IMP_DemTVRegC_Scotland
          +    -0.04204199778897 * IMP_DemTVRegEast  +     0.14668601478707 *
        IMP_DemTVRegLondon  +    -0.07650967623091 * IMP_DemTVRegMidlands
          +    -0.29998204541263 * IMP_DemTVRegN_East
          +    -0.10318630982193 * IMP_DemTVRegN_Scot
          +     0.13908155743388 * IMP_DemTVRegN_West
          +    -0.20386100328521 * IMP_DemTVRegS___S_East
          +     0.10394290013102 * IMP_DemTVRegS_West
          +     0.14799831936696 * IMP_DemTVRegU  +     0.29204280076008 *
        IMP_DemTVRegUlster  +    -0.12796304569207 * IMP_DemTVRegWales___West
          +     0.14908147159117 * PromClassGold  +    -0.18110970980298 *
        PromClassPlatinum  +     0.11889407156235 * PromClassSilver ;
   H11  =    -0.00078709123506 + H11 ;
   H12  =     1.90869847410073 + H12 ;
   H13  =     1.50327717623917 + H13 ;
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
   P_TargetBuy1  =     2.09229198471939 * H11  +    -0.88550855149669 * H12
          +    -1.47737108945392 * H13 ;
   P_TargetBuy1  =    -0.40463507845869 + P_TargetBuy1 ;
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


*** Update Posterior Probabilities;
P_TargetBuy1 = P_TargetBuy1 * 0.05 / 0.2477501799856;
P_TargetBuy0 = P_TargetBuy0 * 0.95 / 0.75224982001439;
drop _sum; _sum = P_TargetBuy1 + P_TargetBuy0 ;
if _sum > 4.135903E-25 then do;
   P_TargetBuy1 = P_TargetBuy1 / _sum;
   P_TargetBuy0 = P_TargetBuy0 / _sum;
end;

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
EP_TARGETBUY = P_TargetBuy1 * 15 + P_TargetBuy0 * -1.5;
drop _sum;
_sum = P_TargetBuy1 * 0 + P_TargetBuy0 * 0;
if _sum > EP_TARGETBUY + 6.82121E-12 then do;
   EP_TARGETBUY = _sum; _decnum = 2;
   D_TARGETBUY = '0' ;
end;

*** Decision Matrix;
array NEURALdema [2,2] _temporary_ (
/* row 1 */  15 0
/* row 2 */  -1.5 0
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
