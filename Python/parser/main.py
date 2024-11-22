import re
import pymysql
from sshtunnel import SSHTunnelForwarder

lines = []
homeTeam = None
awayTeam = None
homeScore = None
awayScore = None
round = 1
league = None



def fixture_parser():
    with open("match4.txt", "rt", encoding="utf8") as file:
        for line in file:
            lines.append(line.rstrip("\n"))
        for element in lines:
            print(element)
        global league
        league = lines[0]
        print(lines[4])

        global homeTeam, awayTeam, homeScore, awayScore

        separatedTeamLine = lines[4].split("-")
        homeTeam = re.search("[^\s\d]+[\w+\s+\w+\S]+[^\s\d]", separatedTeamLine[0]).group()
        awayTeam = re.search("[^\s\d]+[\w+\s+\w+\S]+[^\s\d]", separatedTeamLine[1]).group()
        homeScore = re.search("\d", separatedTeamLine[0]).group()
        awayScore = re.search("\d", separatedTeamLine[1]).group()

    return homeTeam, awayTeam, homeScore, awayScore

def updateTeam(hteam, ateam, hscore, ascore, round, league):
    mydb = pymysql.connect(host="", user="", password="", port=3306, database="u172492500_GLP_Alpha_1_2")
    if mydb:
        print("made connection")
    else:
        print(pymysql.err)
    query = "SELECT * FROM league_table"
    cursor = mydb.cursor()
    cursor.execute('SHOW DATABASES')
    cursor.execute(query)
    set_round = round
    hGD = int(hscore) - int(ascore)
    print(hGD)
    aGD = int(ascore) - int(hscore)
    print(aGD)
    if hscore > ascore:
        hquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+%s, W = W+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND lname = %s;"
        hdata_tuple = (3, hscore, ascore, hGD, hteam, league)
        cursor.execute(hquery, hdata_tuple)

        aquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+%s, L = L+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND lname = %s;"
        adata_tuple = (0, ascore, hscore, aGD, ateam, league)
        cursor.execute(aquery, adata_tuple)

        mydb.commit()
    elif hscore == ascore:
        query1 = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+1, D = D+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s WHERE Teams_tname = %s AND lname = %s;"
        query2 = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+1, D = D+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s WHERE Teams_tname = %s AND lname = %s;"

        hdata_tuple = (hscore, ascore, hteam, league)
        cursor.execute(query1, hdata_tuple)

        adata_tuple = (ascore, hscore, ateam, league)
        cursor.execute(query2, adata_tuple)

        mydb.commit()
    elif hscore < ascore:
        hquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, L = L+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND lname = %s;"

        hdata_tuple = (hscore, ascore, hGD, hteam, league)
        cursor.execute(hquery, hdata_tuple)

        aquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+%s, W = W+1, goalsScored = goalsScored+(%s), goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND lname = %s;"

        adata_tuple = (3, ascore, hscore, aGD, ateam, league)
        cursor.execute(aquery, adata_tuple)

        mydb.commit()



fixture_parser()
print(homeTeam, awayTeam, homeScore, awayScore)

updateTeam(homeTeam, awayTeam, homeScore, awayScore, round, league)


"""def playersUpdate():
    home_players = []
    home_goals = []
    separated_home_goals = lines[5].split(":")
    home_goals_raw = separated_home_goals[1]
    print(home_goals_raw)
    home_goals_raw = separated_home_goals[1].split(",")



    away_players = []
    away_goals = []
    separated_away_goals = lines[6].split(":")
    away_gals_raw = separated_away_goals[1]
    print(away_gals_raw)
    away_goals_split = separated_away_goals[1].split(",")
    print(away_goals_split)
    for i in range(len(away_goals_split)):
        away_players.append(re.search("\w+\s\w+", away_goals_split[i]).group())
        if re.search("\d", away_goals_split[i]):
            away_goals.append(2)
        else:
            away_goals.append(1)
    print(away_players)
    print(away_goals)

playersUpdate()"""