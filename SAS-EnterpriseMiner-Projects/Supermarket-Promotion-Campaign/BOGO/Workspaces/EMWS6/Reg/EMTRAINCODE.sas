*------------------------------------------------------------*;
* Reg: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS6.Impt_TRAIN(keep=
IMP_DemAffl IMP_DemAge IMP_DemClusterGroup IMP_DemGender IMP_DemReg
IMP_DemTVReg IMP_PromTime M_DemAffl M_DemAge M_DemClusterGroup M_DemGender
M_DemReg M_DemTVReg M_PromTime PromClass PromSpend TargetBuy );
run;
*------------------------------------------------------------* ;
* Reg: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_DemClusterGroup(ASC) IMP_DemGender(ASC) IMP_DemReg(ASC) IMP_DemTVReg(ASC)
   M_DemAffl(ASC) M_DemAge(ASC) M_DemClusterGroup(ASC) M_DemGender(ASC)
   M_DemReg(ASC) M_DemTVReg(ASC) M_PromTime(ASC) PromClass(ASC) TargetBuy(DESC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    IMP_DemAffl IMP_DemAge IMP_PromTime PromSpend
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
TargetBuy
;
run;
quit;
*------------------------------------------------------------*;
* Reg: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg_DMDB
validata = EMWS6.Impt_VALIDATE
outest = EMWS6.Reg_EMESTIMATE
outterms = EMWS6.Reg_OUTTERMS
outmap= EMWS6.Reg_MAPDS namelen=200
;
class
TargetBuy
IMP_DemClusterGroup
IMP_DemGender
IMP_DemReg
IMP_DemTVReg
M_DemAffl
M_DemAge
M_DemClusterGroup
M_DemGender
M_DemReg
M_DemTVReg
M_PromTime
PromClass
;
model TargetBuy =
IMP_DemAffl
IMP_DemAge
IMP_DemClusterGroup
IMP_DemGender
IMP_DemReg
IMP_DemTVReg
IMP_PromTime
M_DemAffl
M_DemAge
M_DemClusterGroup
M_DemGender
M_DemReg
M_DemTVReg
M_PromTime
PromClass
PromSpend
/error=binomial link=LOGIT
coding=DEVIATION
nodesignprint
selection=STEPWISE choose=VDECDATA
Hierarchy=CLASS
Rule=NONE
;
;
decision decdata=WORK.TargetBuy
decvars=
Solicit
Ignore
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6\Reg\EMPUBLISHSCORE.sas"
group=Reg
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS6\Reg\EMFLOWSCORE.sas"
group=Reg
residual
;
run;
quit;
