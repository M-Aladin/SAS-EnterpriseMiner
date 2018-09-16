****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_TargetBuy  $   12; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_TargetBuy0 = 'Predicted: TargetBuy=0' ;
label P_TargetBuy1 = 'Predicted: TargetBuy=1' ;
label Q_TargetBuy0 = 'Unadjusted P: TargetBuy=0' ;
label Q_TargetBuy1 = 'Unadjusted P: TargetBuy=1' ;
label I_TargetBuy = 'Into: TargetBuy' ;
label U_TargetBuy = 'Unnormalized Into: TargetBuy' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_1 $      1; DROP _ARBFMT_1; 
_ARBFMT_1 = ' '; /* Initialize to avoid warning. */


******             ASSIGN OBSERVATION TO NODE             ******;
IF  NOT MISSING(Age ) AND 
  Age  <                 44.5 THEN DO;
  _ARBFMT_1 = PUT( Gender , $CHAR1.);
   %DMNORMIP( _ARBFMT_1);
  IF _ARBFMT_1 IN ('F' ) THEN DO;
    _ARBFMT_12 = PUT( MobileApplications , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('0' ) THEN DO;
      IF  NOT MISSING(Age ) AND 
        Age  <                 20.5 THEN DO;
        _NODE_  =                   16;
        _LEAF_  =                    1;
        P_TargetBuy0  =     0.81063122923588;
        P_TargetBuy1  =     0.18936877076411;
        Q_TargetBuy0  =     0.81063122923588;
        Q_TargetBuy1  =     0.18936877076411;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      ELSE DO;
        IF  NOT MISSING(AffluenceGrade ) AND 
          AffluenceGrade  <                  9.5 THEN DO;
          IF  NOT MISSING(Age ) AND 
                            39.5 <= Age  THEN DO;
            _NODE_  =                   65;
            _LEAF_  =                    3;
            P_TargetBuy0  =      0.6913946587537;
            P_TargetBuy1  =     0.30860534124629;
            Q_TargetBuy0  =      0.6913946587537;
            Q_TargetBuy1  =     0.30860534124629;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          ELSE DO;
            _NODE_  =                   64;
            _LEAF_  =                    2;
            P_TargetBuy0  =     0.47519083969465;
            P_TargetBuy1  =     0.52480916030534;
            Q_TargetBuy0  =     0.47519083969465;
            Q_TargetBuy1  =     0.52480916030534;
            I_TargetBuy  = '1' ;
            U_TargetBuy  =                    1;
            END;
          END;
        ELSE DO;
          _NODE_  =                   35;
          _LEAF_  =                    4;
          P_TargetBuy0  =     0.28530670470756;
          P_TargetBuy1  =     0.71469329529243;
          Q_TargetBuy0  =     0.28530670470756;
          Q_TargetBuy1  =     0.71469329529243;
          I_TargetBuy  = '1' ;
          U_TargetBuy  =                    1;
          END;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(AffluenceGrade ) AND 
        AffluenceGrade  <                  7.5 THEN DO;
        IF  NOT MISSING(Age ) AND 
          Age  <                 32.5 THEN DO;
          _NODE_  =                   36;
          _LEAF_  =                    5;
          P_TargetBuy0  =     0.22085889570552;
          P_TargetBuy1  =     0.77914110429447;
          Q_TargetBuy0  =     0.22085889570552;
          Q_TargetBuy1  =     0.77914110429447;
          I_TargetBuy  = '1' ;
          U_TargetBuy  =                    1;
          END;
        ELSE DO;
          _ARBFMT_12 = PUT( FacebookLike , BEST12.);
           %DMNORMIP( _ARBFMT_12);
          IF _ARBFMT_12 IN ('1' ) THEN DO;
            _NODE_  =                   71;
            _LEAF_  =                    7;
            P_TargetBuy0  =     0.44324324324324;
            P_TargetBuy1  =     0.55675675675675;
            Q_TargetBuy0  =     0.44324324324324;
            Q_TargetBuy1  =     0.55675675675675;
            I_TargetBuy  = '1' ;
            U_TargetBuy  =                    1;
            END;
          ELSE DO;
            _NODE_  =                   70;
            _LEAF_  =                    6;
            P_TargetBuy0  =     0.66806722689075;
            P_TargetBuy1  =     0.33193277310924;
            Q_TargetBuy0  =     0.66806722689075;
            Q_TargetBuy1  =     0.33193277310924;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          END;
        END;
      ELSE DO;
        _NODE_  =                   19;
        _LEAF_  =                    8;
        P_TargetBuy0  =      0.1860465116279;
        P_TargetBuy1  =     0.81395348837209;
        Q_TargetBuy0  =      0.1860465116279;
        Q_TargetBuy1  =     0.81395348837209;
        I_TargetBuy  = '1' ;
        U_TargetBuy  =                    1;
        END;
      END;
    END;
  ELSE DO;
    IF  NOT MISSING(AffluenceGrade ) AND 
                      12.5 <= AffluenceGrade  THEN DO;
      _ARBFMT_12 = PUT( MobileApplications , BEST12.);
       %DMNORMIP( _ARBFMT_12);
      IF _ARBFMT_12 IN ('0' ) THEN DO;
        IF  NOT MISSING(TotalSpend ) AND 
                          1400 <= TotalSpend  THEN DO;
          _NODE_  =                   47;
          _LEAF_  =                   17;
          P_TargetBuy0  =     0.77586206896551;
          P_TargetBuy1  =     0.22413793103448;
          Q_TargetBuy0  =     0.77586206896551;
          Q_TargetBuy1  =     0.22413793103448;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        ELSE DO;
          _NODE_  =                   46;
          _LEAF_  =                   16;
          P_TargetBuy0  =     0.38636363636363;
          P_TargetBuy1  =     0.61363636363636;
          Q_TargetBuy0  =     0.38636363636363;
          Q_TargetBuy1  =     0.61363636363636;
          I_TargetBuy  = '1' ;
          U_TargetBuy  =                    1;
          END;
        END;
      ELSE DO;
        _NODE_  =                   22;
        _LEAF_  =                   15;
        P_TargetBuy0  =     0.26347305389221;
        P_TargetBuy1  =     0.73652694610778;
        Q_TargetBuy0  =     0.26347305389221;
        Q_TargetBuy1  =     0.73652694610778;
        I_TargetBuy  = '1' ;
        U_TargetBuy  =                    1;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(Age ) AND 
        Age  <                    9 THEN DO;
        _ARBFMT_12 = PUT( MobileApplications , BEST12.);
         %DMNORMIP( _ARBFMT_12);
        IF _ARBFMT_12 IN ('1' ) THEN DO;
          IF  NOT MISSING(TotalSpend ) AND 
                             515 <= TotalSpend  THEN DO;
            _NODE_  =                   77;
            _LEAF_  =                   10;
            P_TargetBuy0  =                 0.35;
            P_TargetBuy1  =                 0.65;
            Q_TargetBuy0  =                 0.35;
            Q_TargetBuy1  =                 0.65;
            I_TargetBuy  = '1' ;
            U_TargetBuy  =                    1;
            END;
          ELSE DO;
            _NODE_  =                   76;
            _LEAF_  =                    9;
            P_TargetBuy0  =     0.85526315789473;
            P_TargetBuy1  =     0.14473684210526;
            Q_TargetBuy0  =     0.85526315789473;
            Q_TargetBuy1  =     0.14473684210526;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          END;
        ELSE DO;
          _NODE_  =                   41;
          _LEAF_  =                   11;
          P_TargetBuy0  =     0.94010889292196;
          P_TargetBuy1  =     0.05989110707803;
          Q_TargetBuy0  =     0.94010889292196;
          Q_TargetBuy1  =     0.05989110707803;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        END;
      ELSE DO;
        IF  NOT MISSING(Age ) AND 
          Age  <                 29.5 THEN DO;
          _ARBFMT_12 = PUT( MobileApplications , BEST12.);
           %DMNORMIP( _ARBFMT_12);
          IF _ARBFMT_12 IN ('1' ) THEN DO;
            _NODE_  =                   81;
            _LEAF_  =                   13;
            P_TargetBuy0  =             0.078125;
            P_TargetBuy1  =             0.921875;
            Q_TargetBuy0  =             0.078125;
            Q_TargetBuy1  =             0.921875;
            I_TargetBuy  = '1' ;
            U_TargetBuy  =                    1;
            END;
          ELSE DO;
            _NODE_  =                   80;
            _LEAF_  =                   12;
            P_TargetBuy0  =     0.63725490196078;
            P_TargetBuy1  =     0.36274509803921;
            Q_TargetBuy0  =     0.63725490196078;
            Q_TargetBuy1  =     0.36274509803921;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          END;
        ELSE DO;
          _NODE_  =                   43;
          _LEAF_  =                   14;
          P_TargetBuy0  =     0.76848484848484;
          P_TargetBuy1  =     0.23151515151515;
          Q_TargetBuy0  =     0.76848484848484;
          Q_TargetBuy1  =     0.23151515151515;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        END;
      END;
    END;
  END;
ELSE DO;
  IF  NOT MISSING(AffluenceGrade ) AND 
                    12.5 <= AffluenceGrade  THEN DO;
    _ARBFMT_1 = PUT( Gender , $CHAR1.);
     %DMNORMIP( _ARBFMT_1);
    IF _ARBFMT_1 IN ('F' ) THEN DO;
      IF  NOT MISSING(AffluenceGrade ) AND 
                        16.5 <= AffluenceGrade  THEN DO;
        _NODE_  =                   31;
        _LEAF_  =                   24;
        P_TargetBuy0  =     0.13868613138686;
        P_TargetBuy1  =     0.86131386861313;
        Q_TargetBuy0  =     0.13868613138686;
        Q_TargetBuy1  =     0.86131386861313;
        I_TargetBuy  = '1' ;
        U_TargetBuy  =                    1;
        END;
      ELSE DO;
        _ARBFMT_12 = PUT( MobileApplications , BEST12.);
         %DMNORMIP( _ARBFMT_12);
        IF _ARBFMT_12 IN ('0' ) THEN DO;
          _NODE_  =                   59;
          _LEAF_  =                   23;
          P_TargetBuy0  =     0.62574850299401;
          P_TargetBuy1  =     0.37425149700598;
          Q_TargetBuy0  =     0.62574850299401;
          Q_TargetBuy1  =     0.37425149700598;
          I_TargetBuy  = '0' ;
          U_TargetBuy  =                    0;
          END;
        ELSE DO;
          IF  NOT MISSING(DayCareProducts ) AND 
            DayCareProducts  <                  0.5 THEN DO;
            _NODE_  =                  100;
            _LEAF_  =                   21;
            P_TargetBuy0  =     0.69411764705882;
            P_TargetBuy1  =     0.30588235294117;
            Q_TargetBuy0  =     0.69411764705882;
            Q_TargetBuy1  =     0.30588235294117;
            I_TargetBuy  = '0' ;
            U_TargetBuy  =                    0;
            END;
          ELSE DO;
            _NODE_  =                  101;
            _LEAF_  =                   22;
            P_TargetBuy0  =     0.32440476190476;
            P_TargetBuy1  =     0.67559523809523;
            Q_TargetBuy0  =     0.32440476190476;
            Q_TargetBuy1  =     0.67559523809523;
            I_TargetBuy  = '1' ;
            U_TargetBuy  =                    1;
            END;
          END;
        END;
      END;
    ELSE DO;
      IF  NOT MISSING(AffluenceGrade ) AND 
                        17.5 <= AffluenceGrade  THEN DO;
        _NODE_  =                   29;
        _LEAF_  =                   20;
        P_TargetBuy0  =     0.34285714285714;
        P_TargetBuy1  =     0.65714285714285;
        Q_TargetBuy0  =     0.34285714285714;
        Q_TargetBuy1  =     0.65714285714285;
        I_TargetBuy  = '1' ;
        U_TargetBuy  =                    1;
        END;
      ELSE DO;
        _NODE_  =                   28;
        _LEAF_  =                   19;
        P_TargetBuy0  =     0.81767955801104;
        P_TargetBuy1  =     0.18232044198895;
        Q_TargetBuy0  =     0.81767955801104;
        Q_TargetBuy1  =     0.18232044198895;
        I_TargetBuy  = '0' ;
        U_TargetBuy  =                    0;
        END;
      END;
    END;
  ELSE DO;
    _NODE_  =                    6;
    _LEAF_  =                   18;
    P_TargetBuy0  =     0.87801458216489;
    P_TargetBuy1  =      0.1219854178351;
    Q_TargetBuy0  =     0.87801458216489;
    Q_TargetBuy1  =      0.1219854178351;
    I_TargetBuy  = '0' ;
    U_TargetBuy  =                    0;
    END;
  END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
