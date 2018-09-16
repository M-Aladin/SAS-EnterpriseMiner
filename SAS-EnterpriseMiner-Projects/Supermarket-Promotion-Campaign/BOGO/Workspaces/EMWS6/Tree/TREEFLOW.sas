****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_TargetBuy  $   12; 
LENGTH I_TargetBuy  $   12; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;
label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;
label Q_TargetBuy1 = 'Unadjusted P: TargetBuy=1' ;
label Q_TargetBuy0 = 'Unadjusted P: TargetBuy=0' ;
label V_TargetBuy1 = 'Validated: TargetBuy=1' ;
label V_TargetBuy0 = 'Validated: TargetBuy=0' ;
label R_TargetBuy1 = 'Residual: TargetBuy=1' ;
label R_TargetBuy0 = 'Residual: TargetBuy=0' ;
label F_TargetBuy = 'From: TargetBuy' ;
label I_TargetBuy = 'Into: TargetBuy' ;
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1; 
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */


_ARBFMT_12 = PUT( TargetBuy , BEST12.);
 %DMNORMCP( _ARBFMT_12, F_TargetBuy );

******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(DemAge ) AND 
  DemAge  <                 44.5 THEN DO;
  _NODE_  =                    2;
  _LEAF_  =                    1;
  P_TargetBuy1  =      0.5251560778553;
  P_TargetBuy0  =     0.47484392214469;
  Q_TargetBuy1  =      0.5251560778553;
  Q_TargetBuy0  =     0.47484392214469;
  V_TargetBuy1  =     0.51843817787418;
  V_TargetBuy0  =     0.48156182212581;
  I_TargetBuy  = '1' ;
  U_TargetBuy  =                    1;
  END;
ELSE DO;
  IF  NOT MISSING(DemAffl ) AND 
                    12.5 <= DemAffl  THEN DO;
    _NODE_  =                    7;
    _LEAF_  =                    7;
    P_TargetBuy1  =     0.43688118811881;
    P_TargetBuy0  =     0.56311881188118;
    Q_TargetBuy1  =     0.43688118811881;
    Q_TargetBuy0  =     0.56311881188118;
    V_TargetBuy1  =     0.44949494949494;
    V_TargetBuy0  =     0.55050505050505;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                   12;
      _LEAF_  =                    2;
      P_TargetBuy1  =     0.18772470467385;
      P_TargetBuy0  =     0.81227529532614;
      Q_TargetBuy1  =     0.18772470467385;
      Q_TargetBuy0  =     0.81227529532614;
      V_TargetBuy1  =     0.19157288667887;
      V_TargetBuy0  =     0.80842711332112;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(DemAffl ) AND 
        DemAffl  <                  8.5 THEN DO;
        IF  NOT MISSING(DemAge ) AND 
          DemAge  <                 76.5 THEN DO;
          IF  NOT MISSING(DemAffl ) AND 
            DemAffl  <                  5.5 THEN DO;
            _NODE_  =                   56;
            _LEAF_  =                    3;
            P_TargetBuy1  =     0.01213960546282;
            P_TargetBuy0  =     0.98786039453717;
            Q_TargetBuy1  =     0.01213960546282;
            Q_TargetBuy0  =     0.98786039453717;
            V_TargetBuy1  =     0.01904761904761;
            V_TargetBuy0  =     0.98095238095238;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          ELSE DO;
            _NODE_  =                   57;
            _LEAF_  =                    4;
            P_TargetBuy1  =      0.0456333595594;
            P_TargetBuy0  =     0.95436664044059;
            Q_TargetBuy1  =      0.0456333595594;
            Q_TargetBuy0  =     0.95436664044059;
            V_TargetBuy1  =     0.03894080996884;
            V_TargetBuy0  =     0.96105919003115;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          END;
        ELSE DO;
          _NODE_  =                   47;
          _LEAF_  =                    5;
          P_TargetBuy1  =     0.09881422924901;
          P_TargetBuy0  =     0.90118577075098;
          Q_TargetBuy1  =     0.09881422924901;
          Q_TargetBuy0  =     0.90118577075098;
          V_TargetBuy1  =      0.0813953488372;
          V_TargetBuy0  =     0.91860465116279;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        END;
      ELSE DO;
        _NODE_  =                   27;
        _LEAF_  =                    6;
        P_TargetBuy1  =     0.09840425531914;
        P_TargetBuy0  =     0.90159574468085;
        Q_TargetBuy1  =     0.09840425531914;
        Q_TargetBuy0  =     0.90159574468085;
        V_TargetBuy1  =     0.09423076923076;
        V_TargetBuy0  =     0.90576923076923;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    END;
  END;

*****  RESIDUALS R_ *************;
IF  F_TargetBuy  NE '1' 
AND F_TargetBuy  NE '0'  THEN DO; 
        R_TargetBuy1  = .;
        R_TargetBuy0  = .;
 END;
 ELSE DO;
       R_TargetBuy1  =  -P_TargetBuy1 ;
       R_TargetBuy0  =  -P_TargetBuy0 ;
       SELECT( F_TargetBuy  );
          WHEN( '1'  ) R_TargetBuy1  = R_TargetBuy1  +1;
          WHEN( '0'  ) R_TargetBuy0  = R_TargetBuy0  +1;
       END;
 END;

*****  DECISION VARIABLES *******;

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
array TREEdema [2,2] _temporary_ (
/* row 1 */  15 0
/* row 2 */  -0.5 0
);

*** Find Index of Target Category;
drop _tarnum; select( F_TargetBuy );
   when('1' ) _tarnum = 1;
   when('0' ) _tarnum = 2;
   otherwise _tarnum = 0;
end;
if _tarnum <= 0 then goto TREEdeex;

*** Computed Consequence of Chosen Decision;
CP_TARGETBUY = TREEdema [_tarnum,_decnum];

*** Best Possible Consequence of Any Decision without Cost;
array TREEdebe [2] _temporary_ ( 15 0);
BP_TARGETBUY = TREEdebe [_tarnum];


TREEdeex:;

*** End Decision Processing ;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

