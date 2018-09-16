if
_SEGMENT_LABEL_ not in ( 'Cluster1' , 'Cluster2' , 'Cluster3')
then do;
if M_FILTER eq . then M_FILTER = 0;
else M_FILTER = M_FILTER + 0;
end;
else M_FILTER = 1;
label M_FILTER = 'Filtered Indicator';
length M_FILTER 8;
