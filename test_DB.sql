INSERT INTO Players (pid, Teams_tid, pname, pDOB, jerseyNo, ppos, prole, puserName) VALUES (1,1,Test Player,2000-01-01,5,FW,P,testname);
INSERT INTO Teams (tid, tname, tabbrv, League_lid, Seasons_seasonid) VALUES (1,Blancos United,BLU,1,1);
INSERT INTO Leagues (lid,lname) VALUES (1, Test League);
SELECT pname, jerseyNo, ppos, pDOB, lname, tname FROM Players, Teams, Leagues;