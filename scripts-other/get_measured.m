
% Add observed lake level to structure
% NOTE: lake.levelObs.XX structure columns -> change, date number (1 1 1900)
lake.levelObs.LF = lakeDelta(1:37,1:2);
lake.levelObs.LH = lakeDelta(:,3:4);
lake.levelObs.LB = lakeDelta(1:37,5:6);
