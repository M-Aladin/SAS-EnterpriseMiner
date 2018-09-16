*------------------------------------------------------------*;
* Reg: Create decision matrix;
*------------------------------------------------------------*;
data WORK.TargetBuy;
  length   TargetBuy                        $  32
           COUNT                                8
           DATAPRIOR                            8
           TRAINPRIOR                           8
           DECPRIOR                             8
           Solicit                              8
           Ignore                               8
           ;

  label    COUNT="Level Counts"
           DATAPRIOR="Data Proportions"
           TRAINPRIOR="Training Proportions"
           DECPRIOR="Decision Priors"
           Solicit="1"
           Ignore="0"
           ;
  format   COUNT 10.
           ;
TargetBuy="1"; COUNT=5505; DATAPRIOR=0.24771632992845; TRAINPRIOR=0.24771632992845; DECPRIOR=0.05; Solicit=15; Ignore=0;
output;
TargetBuy="0"; COUNT=16718; DATAPRIOR=0.75228367007154; TRAINPRIOR=0.75228367007154; DECPRIOR=0.95; Solicit=-1.5; Ignore=0;
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
set EMWS5.Impt_TRAIN(keep=
IMP_DemAffl IMP_DemAge IMP_DemClusterGroup IMP_DemGender IMP_DemReg
IMP_DemTVReg IMP_PromTime PromClass PromSpend TargetBuy );
run;
*------------------------------------------------------------* ;
* Reg: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    IMP_DemClusterGroup(ASC) IMP_DemGender(ASC) IMP_DemReg(ASC) IMP_DemTVReg(ASC)
   PromClass(ASC) TargetBuy(DESC)
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
validata = EMWS5.Impt_VALIDATE
outest = EMWS5.Reg_EMESTIMATE
outterms = EMWS5.Reg_OUTTERMS
outmap= EMWS5.Reg_MAPDS namelen=200
;
class
TargetBuy
IMP_DemClusterGroup
IMP_DemGender
IMP_DemReg
IMP_DemTVReg
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
priorVar=DECPRIOR
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS5\Reg\EMPUBLISHSCORE.sas"
group=Reg
;
code file="D:\Nida\Data mining\datamining\BOGO\Workspaces\EMWS5\Reg\EMFLOWSCORE.sas"
group=Reg
residual
;
run;
quit;
