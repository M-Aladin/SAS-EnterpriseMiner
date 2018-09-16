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
IF  NOT MISSING(DemAge ) AND 
  DemAge  <                 44.5 THEN DO;
  IF  NOT MISSING(DemAffl ) AND 
    DemAffl  <                  9.5 THEN DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_TargetBuy1  =     0.12521449273075;
      P_TargetBuy0  =     0.87478550726924;
      Q_TargetBuy1  =     0.47248803827751;
      Q_TargetBuy0  =     0.52751196172248;
      V_TargetBuy1  =     0.13702490437956;
      V_TargetBuy0  =     0.86297509562043;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    ELSE DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_TargetBuy1  =     0.04596958753774;
      P_TargetBuy0  =     0.95403041246225;
      Q_TargetBuy1  =     0.23166666666666;
      Q_TargetBuy0  =     0.76833333333333;
      V_TargetBuy1  =     0.03897680789004;
      V_TargetBuy0  =     0.96102319210995;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  ELSE DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_TargetBuy1  =     0.26804610070088;
    P_TargetBuy0  =     0.73195389929911;
    Q_TargetBuy1  =     0.69619269619269;
    Q_TargetBuy0  =      0.3038073038073;
    V_TargetBuy1  =     0.25142381122388;
    V_TargetBuy0  =     0.74857618877611;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(DemAffl ) AND 
                    12.5 <= DemAffl  THEN DO;
    IF  NOT MISSING(DemAffl ) AND 
                      16.5 <= DemAffl  THEN DO;
      IF  NOT MISSING(DemAffl ) AND 
                        19.5 <= DemAffl  THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                   12;
        P_TargetBuy1  =                    1;
        P_TargetBuy0  =                    0;
        Q_TargetBuy1  =                    1;
        Q_TargetBuy0  =                    0;
        V_TargetBuy1  =     0.79324961250118;
        V_TargetBuy0  =     0.20675038749881;
        I_TargetBuy  = '1' ;
        U_TargetBuy  =                    1;
        END;
      ELSE DO;
        _ARBFMT_1 = PUT( DemGender , $1.);
         %DMNORMIP( _ARBFMT_1);
        IF _ARBFMT_1 IN ('M' ,'F' ) THEN DO;
          _NODE_  =                   50;
          _LEAF_  =                   10;
          P_TargetBuy1  =     0.30985946464877;
          P_TargetBuy0  =     0.69014053535122;
          Q_TargetBuy1  =               0.7375;
          Q_TargetBuy0  =               0.2625;
          V_TargetBuy1  =     0.28959851746079;
          V_TargetBuy0  =      0.7104014825392;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   51;
          _LEAF_  =                   11;
          P_TargetBuy1  =      0.0565391977598;
          P_TargetBuy0  =     0.94346080224019;
          Q_TargetBuy1  =     0.27272727272727;
          Q_TargetBuy0  =     0.72727272727272;
          V_TargetBuy1  =       0.017452724809;
          V_TargetBuy0  =     0.98254727519099;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        END;
      END;
    ELSE DO;
      _ARBFMT_1 = PUT( DemGender , $1.);
       %DMNORMIP( _ARBFMT_1);
      IF _ARBFMT_1 IN ('F' ) THEN DO;
        _NODE_  =                   29;
        _LEAF_  =                    9;
        P_TargetBuy1  =     0.12315910342352;
        P_TargetBuy0  =     0.87684089657647;
        Q_TargetBuy1  =     0.46778042959427;
        Q_TargetBuy0  =     0.53221957040572;
        V_TargetBuy1  =     0.15708995374012;
        V_TargetBuy0  =     0.84291004625987;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      ELSE DO;
        _NODE_  =                   28;
        _LEAF_  =                    8;
        P_TargetBuy1  =       0.047965727085;
        P_TargetBuy0  =     0.95203427291499;
        Q_TargetBuy1  =     0.23970037453183;
        Q_TargetBuy0  =     0.76029962546816;
        V_TargetBuy1  =      0.0432988312629;
        V_TargetBuy0  =     0.95670116873709;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _ARBFMT_1 = PUT( DemGender , $1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      IF  NOT MISSING(DemAffl ) AND 
        DemAffl  <                  8.5 THEN DO;
        _NODE_  =                   24;
        _LEAF_  =                    4;
        P_TargetBuy1  =     0.02329606909838;
        P_TargetBuy0  =     0.97670393090161;
        Q_TargetBuy1  =     0.12987012987012;
        Q_TargetBuy0  =     0.87012987012987;
        V_TargetBuy1  =     0.02191427031849;
        V_TargetBuy0  =     0.97808572968151;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      ELSE DO;
        IF  NOT MISSING(DemAge ) THEN DO;
          _NODE_  =                   44;
          _LEAF_  =                    5;
          P_TargetBuy1  =     0.04782994233658;
          P_TargetBuy0  =     0.95217005766341;
          Q_TargetBuy1  =      0.2391581632653;
          Q_TargetBuy0  =     0.76084183673469;
          V_TargetBuy1  =     0.05246968439508;
          V_TargetBuy0  =     0.94753031560491;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   45;
          _LEAF_  =                    6;
          P_TargetBuy1  =     0.11442142510043;
          P_TargetBuy0  =     0.88557857489956;
          Q_TargetBuy1  =     0.44705882352941;
          Q_TargetBuy0  =     0.55294117647058;
          V_TargetBuy1  =     0.11529822686159;
          V_TargetBuy0  =      0.8847017731384;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        END;
      END;
    ELSE DO;
      _NODE_  =                   13;
      _LEAF_  =                    7;
      P_TargetBuy1  =     0.01095571920199;
      P_TargetBuy0  =       0.989044280798;
      Q_TargetBuy1  =     0.06482234879305;
      Q_TargetBuy0  =     0.93517765120694;
      V_TargetBuy1  =     0.01039029633862;
      V_TargetBuy0  =     0.98960970366137;
      I_TargetBuy  = '0' ;
      U_TargetBuy  =                    0;
      END;
    END;
  END;

*****  DECISION VARIABLES *******;

*** Decision Processing;
label D_TARGETBUY = 'Decision: TargetBuy' ;
label EP_TARGETBUY = 'Expected Profit: TargetBuy' ;

length D_TARGETBUY $ 7;

D_TARGETBUY = ' ';
EP_TARGETBUY = .;

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


*** End Decision Processing ;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

