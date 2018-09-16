if NAME="Age" then do;
ROLE="REJECTED";
COMMENT= "Replaced by Repl";
end;
else
if NAME="REP_Age" then do;
ROLE="INPUT";
LEVEL="INTERVAL";
end;
else
if NAME="LoyaltyTime" then do;
ROLE="REJECTED";
COMMENT= "Replaced by Repl";
end;
else
if NAME="REP_LoyaltyTime" then do;
ROLE="INPUT";
LEVEL="INTERVAL";
end;
if NAME="AdvertisementZone" then ROLE="REJECTED";
else
if NAME="REP_AdvertisementZone" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="ClusterGroup" then ROLE="REJECTED";
else
if NAME="REP_ClusterGroup" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="Gender" then ROLE="REJECTED";
else
if NAME="REP_Gender" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
else
if NAME="Region" then ROLE="REJECTED";
else
if NAME="REP_Region" then do;
ROLE="INPUT";
LEVEL="NOMINAL";
end;
