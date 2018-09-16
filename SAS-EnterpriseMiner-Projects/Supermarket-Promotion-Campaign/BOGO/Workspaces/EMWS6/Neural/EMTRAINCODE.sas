*------------------------------------------------------------*;
* Neural: Create decision matrix;
*------------------------------------------------------------*;
data WORK.TargetBuy;
  length   TargetBuy                        $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           DECISION1                            8
           DECISION2                            8
           Solicit                              8
           Ignore                               8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           DECISION1="1"
           DECISION2="0"
           Solicit="1"
           Ignore="0"
           ;
  format   COUNT 10.
           ;
TargetBuy="1"; COUNT=5505; DATAPRIOR=0.24771632992845; TRAINPRIOR=0.24771632992845; DECPRIOR=0.2477; DECISION1=1; DECISION2=0; Solicit=15; Ignore=0;
output;
TargetBuy="0"; COUNT=16718; DATAPRIOR=0.75228367007154; TRAINPRIOR=0.75228367007154; DECPRIOR=0.7523; DECISION1=0; DECISION2=1; Solicit=-0.5; Ignore=0;
output;
;
run;
proc datasets lib=work nolist;
modify TargetBuy(type=PROFIT label=TargetBuy);
label Solicit= '1';
label Ignore= '0';
run;
quit;
data EM_Neural;
set EMWS6.Impt_TRAIN(keep=
IMP_DemAffl IMP_DemAge IMP_DemClusterGroup IMP_DemGender IMP_DemReg
IMP_DemTVReg IMP_PromTime M_DemAffl M_DemAge M_DemClusterGroup M_DemGender
M_DemReg M_DemTVReg M_PromTime PromClass PromSpend TargetBuy );
run;
*------------------------------------------------------------* ;
* Neural: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_DemClusterGroup(ASC) IMP_DemGender(ASC) IMP_DemReg(ASC) IMP_DemTVReg(ASC)
   M_DemAffl(ASC) M_DemAge(ASC) M_DemClusterGroup(ASC) M_DemGender(ASC)
   M_DemReg(ASC) M_DemTVReg(ASC) M_PromTime(ASC) PromClass(ASC) TargetBuy(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_DemAffl IMP_DemAge IMP_PromTime PromSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural
dmdbcat=WORK.Neural_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
TargetBuy
;
run;
quit;
*------------------------------------------------------------* ;
* Neural: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    IMP_DemAffl IMP_DemAge IMP_PromTime PromSpend
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;
    M_DemAffl M_DemAge M_DemClusterGroup M_DemGender M_DemReg M_DemTVReg
   M_PromTime
%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    IMP_DemClusterGroup IMP_DemGender IMP_DemReg IMP_DemTVReg PromClass
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS6.Impt_VALIDATE
random=12345
;
nloptions
;
performance alldetails noutilfile;
decision decdata=WORK.TargetBuy
decvars=
Solicit
Ignore
;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %BININPUTS / level=nominal id=bin
;
input %NOMINPUTS / level=nominal id=nom
;
target TargetBuy / level=NOMINAL id=TargetBuy
bias
;
arch MLP
Hidden=3
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS6.Neural_PRELIM_OUTEST
;
save network=EMWS6.Neural_NETWORK.dm_neural;
train Maxiter=50
maxtime=14400
Outest=EMWS6.Neural_outest estiter=1
Outfit=EMWS6.Neural_OUTFIT
;
run;
quit;
proc sort data=EMWS6.Neural_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural;
by DESCENDING _VAPROF_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS6.Neural_INITIAL;
set EMWS6.Neural_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural dmdbcat=WORK.Neural_DMDB
validdata = EMWS6.Impt_VALIDATE
network = EMWS6.Neural_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
decision decdata=WORK.TargetBuy
decvars=
Solicit
Ignore
;
initial inest=EMWS6.Neural_INITIAL;
train tech=NONE;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6\Neural\SCORECODE.sas"
group=Neural
;
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6\Neural\RESIDUALSCORECODE.sas"
group=Neural
residual
;
;
score data=EMWS6.Impt_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS6.Neural_OUTKEY;
score data=EMWS6.Impt_VALIDATE out=_NULL_
outfit=WORK.FIT2
role=VALID
outkey=EMWS6.Neural_OUTKEY;
run;
quit;
data EMWS6.Neural_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS6.Neural_EMESTIMATE;
set EMWS6.Neural_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural;
run;
quit;
