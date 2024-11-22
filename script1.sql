CREATE VIEW `view1` AS
SELECT date, homeID, awayID FROM Fixtures GROUP BY date;
SELECT homeGoals, awayGoals FROM Fixtrure_results;