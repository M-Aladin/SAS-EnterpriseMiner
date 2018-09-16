****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
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
label I_TargetBuy = 'Into: TargetBuy' ;
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1; 
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */


******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(REP_Age ) AND 
  REP_Age  <                 39.5 THEN DO;
  _ARBFMT_1 = PUT( REP_Gender , $CHAR1.);
   %DMNORMIP( _ARBFMT_1);
  IF _ARBFMT_1 IN ('M' ) THEN DO;
    _NODE_  =                    4;
    _LEAF_  =                    1;
    P_TargetBuy1  =                  0.4;
    P_TargetBuy0  =                  0.6;
    Q_TargetBuy1  =                  0.4;
    Q_TargetBuy0  =                  0.6;
    V_TargetBuy1  =     0.42857142857142;
    V_TargetBuy0  =     0.57142857142857;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    2;
    P_TargetBuy1  =                 0.72;
    P_TargetBuy0  =                 0.28;
    Q_TargetBuy1  =                 0.72;
    Q_TargetBuy0  =                 0.28;
    V_TargetBuy1  =     0.68421052631578;
    V_TargetBuy0  =     0.31578947368421;
    I_TargetBuy  = '1' ;
    U_TargetBuy  =                    1;
    END;
  END;
ELSE DO;
  _ARBFMT_1 = PUT( REP_Gender , $CHAR1.);
   %DMNORMIP( _ARBFMT_1);
  IF _ARBFMT_1 IN ('M' ) THEN DO;
    _NODE_  =                    6;
    _LEAF_  =                    3;
    P_TargetBuy1  =     0.08680555555555;
    P_TargetBuy0  =     0.91319444444444;
    Q_TargetBuy1  =     0.08680555555555;
    Q_TargetBuy0  =     0.91319444444444;
    V_TargetBuy1  =     0.08049535603715;
    V_TargetBuy0  =     0.91950464396284;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  ELSE DO;
    IF  NOT MISSING(DayCareProducts ) AND 
      DayCareProducts  <                  0.5 THEN DO;
      _NODE_  =                   14;
      _LEAF_  =                    4;
      P_TargetBuy1  =     0.10852713178294;
      P_TargetBuy0  =     0.89147286821705;
      Q_TargetBuy1  =     0.10852713178294;
      Q_TargetBuy0  =     0.89147286821705;
      V_TargetBuy1  =     0.18348623853211;
      V_TargetBuy0  =     0.81651376146789;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      IF  NOT MISSING(CleanserProducts ) AND 
                         3.5 <= CleanserProducts  THEN DO;
        _ARBFMT_12 = PUT( MobileApplications , BEST12.);
         %DMNORMIP( _ARBFMT_12);
        IF _ARBFMT_12 IN ('0' ) THEN DO;
          _NODE_  =                   31;
          _LEAF_  =                    7;
          P_TargetBuy1  =      0.3076923076923;
          P_TargetBuy0  =     0.69230769230769;
          Q_TargetBuy1  =      0.3076923076923;
          Q_TargetBuy0  =     0.69230769230769;
          V_TargetBuy1  =                  0.2;
          V_TargetBuy0  =                  0.8;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   30;
          _LEAF_  =                    6;
          P_TargetBuy1  =     0.64516129032258;
          P_TargetBuy0  =     0.35483870967741;
          Q_TargetBuy1  =     0.64516129032258;
          Q_TargetBuy0  =     0.35483870967741;
          V_TargetBuy1  =                 0.68;
          V_TargetBuy0  =                 0.32;
          I_TargetBuy  = '1' ;
          U_TargetBuy  =                    1;
          END;
        END;
      ELSE DO;
        _NODE_  =                   22;
        _LEAF_  =                    5;
        P_TargetBuy1  =     0.24342105263157;
        P_TargetBuy0  =     0.75657894736842;
        Q_TargetBuy1  =     0.24342105263157;
        Q_TargetBuy0  =     0.75657894736842;
        V_TargetBuy1  =     0.27364864864864;
        V_TargetBuy0  =     0.72635135135135;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    END;
  END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

