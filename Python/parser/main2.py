import pymysql

def update_database():
    mydb = pymysql.connect(host="141.136.43.1", user="u172492500_kobuzov2", password="Babuka65", port=3306, database="u172492500_GLP_Alpha_1_2")
    if mydb:
        print("Connected")
    print("made connection")
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
        hquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+%s, W = W+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND Leagues_lid = %s;"
        hdata_tuple = (3, hscore, ascore, hGD, hteam, league)
        cursor.execute(hquery, hdata_tuple)

        aquery = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+%s, L = L+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND Leagues_lid = %s;"
        adata_tuple = (0, ascore, hscore, aGD, ateam, league)
        cursor.execute(aquery, adata_tuple)

        mydb.commit()
    elif hscore == ascore:
        query = "UPDATE league_table SET gamesPlayed = gamesPlayed+1, Pts = Pts+1, D = D+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND Leagues_lid = %s;"

        hdata_tuple = (set_round, hscore, ascore, hGD, hteam, league)
        cursor.execute(query, hdata_tuple)
        print(cursor.execute(query, hdata_tuple))
        adata_tuple = (set_round, ascore, hscore, aGD, ateam, league)
        cursor.execute(query, adata_tuple)

        mydb.commit()
    elif hscore < ascore:
        hquery = "UPDATE league_table SET gamesPlayed = %s, L = L+1, goalsScored = goalsScored+%s, goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND Leagues_lid = %s;"

        hdata_tuple = (set_round, hscore, ascore, hGD, hteam, league)
        cursor.execute(hquery, hdata_tuple)

        aquery = "UPDATE league_table SET gamesPlayed = %s, Pts = Pts+%s, W = W+1, goalsScored = goalsScored+(%s), goalsConceded = goalsConceded+%s, goalDifference = goalDifference+(%s) WHERE Teams_tname = %s AND Leagues_lid = %s;"

        adata_tuple = (set_round, 3, ascore, hscore, aGD, ateam, league)
        cursor.execute(aquery, adata_tuple)

        mydb.commit()