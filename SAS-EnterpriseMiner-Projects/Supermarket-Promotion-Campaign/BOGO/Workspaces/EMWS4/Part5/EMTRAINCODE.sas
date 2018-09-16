*------------------------------------------------------------*;
* Part5: Retrieving stratification variable(s) levels;
*------------------------------------------------------------*;
proc freq data=EMWS4.Filter3_TRAIN noprint;
format
TargetBuy BEST12.0
;
table
TargetBuy
/out=WORK.Part5_FREQ(drop=percent);
run;
proc sort data=WORK.Part5_FREQ;
by descending count;
run;
* Part5: Retrieving levels that meet minimum requirement;
data WORK.Part5_FREQ2(keep = count);
set WORK.Part5_FREQ;
where (.01 * 50 * count) >= 3;
run;
*------------------------------------------------------------*;
* Part5: Create stratified partitioning;
*------------------------------------------------------------*;
data
EMWS4.Part5_TRAIN(label="")
EMWS4.Part5_VALIDATE(label="")
;
retain _seed_ 12345;
drop _seed_ _genvalue_;
call ranuni(_seed_, _genvalue_);
label _dataobs_ = "%sysfunc(sasmsg(sashelp.dmine, sample_dataobs_vlabel, NOQUOTE))";
_dataobs_ = _N_;
drop _c00:;
set EMWS4.Filter3_TRAIN;
length _Pformat1 $58;
drop _Pformat1;
_Pformat1 = strip(put(TargetBuy, BEST12.0));
if
_Pformat1 = '0'
then do;
if (5043+1-_C000003)*_genvalue_ <= (2522 - _C000001) then do;
_C000001 + 1;
output EMWS4.Part5_TRAIN;
end;
else do;
_C000002 + 1;
output EMWS4.Part5_VALIDATE;
end;
_C000003+1;
end;
else if
_Pformat1 = '1'
then do;
if (1181+1-_C000006)*_genvalue_ <= (591 - _C000004) then do;
_C000004 + 1;
output EMWS4.Part5_TRAIN;
end;
else do;
_C000005 + 1;
output EMWS4.Part5_VALIDATE;
end;
_C000006+1;
end;
run;
