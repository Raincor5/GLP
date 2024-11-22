import mysql.connector
import sshtunnel



cursor = mydb.cursor()
cursor.execute('SHOW DATABASES')


def updateTeam(hteam, ateam, hscore, ascore, round):
    sshtunnel.SSH_TIMEOUT = 5.0
    sshtunnel.TUNNEL_TIMEOUT = 5.0

    with sshtunnel.SSHTunnelForwarder(
            ('host29.codeanyhost.com'),
            ssh_username='cabox',
            ssh_pkey="test",
            remote_bind_address=(
            '127.0.0.1', 3306)
    ) as tunnel:
        mydb = mysql.connector.connect(
            user='root', password='c85OCpmwcM4Shn4U',
            host='127.0.0.1', port=tunnel.local_bind_port,
            database='GLP_alpha_1.0',
        )
        query = "SELECT * FROM glptable_new;"
        cursor.execute(query)
        set_round = round
        hGD = hscore - ascore
        aGD = ascore - hscore
        if hscore > ascore:
            hquery = "UPDATE glptable_new SET GP = %s, Pts = Pts+%s, W = W+1, GS = GS+%s, GC = GC+%s, GD = GD+%s WHERE Team = %s"
            hdata_tuple = (set_round, 3, hscore, ascore, hGD, hteam)
            cursor.execute(hquery, hdata_tuple)

            aquery = "UPDATE glptable_new SET GP = %s, Pts = Pts+%s, L = L+1, GS = GS+%s, GC = GC+%s, GD = GD+%s WHERE Team = %s"
            adata_tuple = (set_round, 0, ascore, hscore, aGD, ateam)
            cursor.execute(aquery, adata_tuple)

            mydb.commit()
        elif hscore == ascore:
            query = "UPDATE glptable_new SET GP = %s, Pts = Pts+1, D = D+1, GS = GS+%s, GC = GC+%s, GD = GD+%s WHERE Team = %s"

            hdata_tuple = (set_round, hscore, ascore, hGD, hteam)
            cursor.execute(query, hdata_tuple)
            adata_tuple = (set_round, ascore, hscore, aGD, ateam)
            cursor.execute(query, adata_tuple)

            mydb.commit()
        elif hscore < ascore:
            hquery = "UPDATE glptable_new SET GP = %s, Pts = Pts+%s, L = L+1, GS = GS+%s, GC = GC+%s, GD = GD+%s WHERE Team = %s"

            hdata_tuple = (set_round, 0, hscore, ascore, hGD, hteam)
            cursor.execute(hquery, hdata_tuple)

            aquery = "UPDATE glptable_new SET GP = %s, Pts = Pts+%s, W = W+1, GS = GS+%s, GC = GC+%s, GD = GD+%s WHERE Team = %s"

            adata_tuple = (set_round, 3, ascore, hscore, aGD, ateam)
            cursor.execute(aquery, adata_tuple)

            mydb.commit()
        mydb.close()


updateTeam("Amkal", "Saburtalo", 2, 1)
updateTeam("Zenit", "Melomania", 3, 7)
updateTeam("Zugdidi", "Gardabani", 1, 0)
updateTeam("Blancos United", "Algeti", 0, 3)
updateTeam("Dinamo Tbilisi", "Rubin", 3, 0)
updateTeam("Shark Team", "Rioni", 0, 3)