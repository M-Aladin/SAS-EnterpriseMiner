* ;
*Variable: Age;
* ;
Label REP_Age= 'Replacement: Age';
length REP_Age 8;
REP_Age= Age;
if Age eq . then REP_Age = .;
else
if Age<1 then REP_Age=.;
