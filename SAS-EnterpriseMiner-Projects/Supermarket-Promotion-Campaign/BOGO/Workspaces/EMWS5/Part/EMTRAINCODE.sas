*------------------------------------------------------------*;
* Part: Retrieving stratification variable(s) levels;
*------------------------------------------------------------*;
proc freq data=EMWS5.Ids_DATA noprint;
table
TargetBuy
/out=WORK.Part_FREQ(drop=percent);
run;
proc sort data=WORK.Part_FREQ;
by descending count;
run;
* Part: Retrieving levels that meet minimum requirement;
data WORK.Part_FREQ2(keep = count);
set WORK.Part_FREQ;
where (.01 * 50 * count) >= 3;
run;
*------------------------------------------------------------*;
* Part: Create stratified partitioning;
*------------------------------------------------------------*;
data
EMWS5.Part_TRAIN(label="")
EMWS5.Part_VALIDATE(label="")
;
retain _seed_ 12345;
drop _seed_ _genvalue_;
call ranuni(_seed_, _genvalue_);
label _dataobs_ = "%sysfunc(sasmsg(sashelp.dmine, sample_dataobs_vlabel, NOQUOTE))";
_dataobs_ = _N_;
drop _c00:;
set EMWS5.Ids_DATA;
if
TargetBuy = 0
then do;
if (16718+1-_C000003)*_genvalue_ <= (8359 - _C000001) then do;
_C000001 + 1;
output EMWS5.Part_TRAIN;
end;
else do;
_C000002 + 1;
output EMWS5.Part_VALIDATE;
end;
_C000003+1;
end;
else if
TargetBuy = 1
then do;
if (5505+1-_C000006)*_genvalue_ <= (2753 - _C000004) then do;
_C000004 + 1;
output EMWS5.Part_TRAIN;
end;
else do;
_C000005 + 1;
output EMWS5.Part_VALIDATE;
end;
_C000006+1;
end;
run;
