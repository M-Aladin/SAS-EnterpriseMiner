*------------------------------------------------------------*;
* Score: Creating Fixed Names;
*------------------------------------------------------------*;
LABEL EM_SEGMENT = 'Segment';
EM_SEGMENT = b_TargetBuy;
LENGTH EM_EVENTPROBABILITY 8;
LABEL EM_EVENTPROBABILITY = 'Probability for level 1 of TargetBuy';
EM_EVENTPROBABILITY = P_TargetBuy1;
LENGTH EM_PROBABILITY 8;
LABEL EM_PROBABILITY = 'Probability of Classification';
EM_PROBABILITY =
max(
P_TargetBuy1
,
P_TargetBuy0
);
LENGTH EM_CLASSIFICATION $%dmnorlen;
LABEL EM_CLASSIFICATION = "Prediction for TargetBuy";
EM_CLASSIFICATION = I_TargetBuy;
LENGTH EM_DECISION $%dmnorlen;
LABEL EM_DECISION= "Recommended Decision for TargetBuy";
EM_DECISION = D_TargetBuy;
LENGTH EM_PROFIT 8;
LABEL EM_PROFIT= "Expected Profit for TargetBuy";
EM_PROFIT = EP_TARGETBUY;
LABEL EM_CLASSTARGET = 'Target Variable: TargetBuy';
EM_CLASSTARGET = F_TargetBuy;
