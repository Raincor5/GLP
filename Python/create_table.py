import mysql.connector

f = open('F:\GLP\Python\Teams\Blancos United\BUplayers.csv')
fString = f.read()

fList = []
for line in fString.split('\n'):
    fList.append(line.split(','))

print(fList)


import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='GLPadmin',
    database='glp_table_db',
    buffered = True
)
print(mydb)


cursor = mydb.cursor()
cursor.execute('SHOW DATABASES')

PN = fList[0][0]
Forename = fList[0][1]
Surname = fList[0][2]
YOB = fList[0][3]
ID = fList[0][4]
isFW = fList[0][5]
isGK = fList[0][6]
isMNGR = fList[0][7]
isWNR = fList[0][8]
MP = fList[0][9]
GD = fList[0][10]

queryCreateTable = """CREATE TABLE BLANCOSPLAYERS(
                    {} int(2) PRIMARY KEY,
                    {} varchar(255) not null,
                    {} varchar(255) not null,
                    {} year(4) not null,
                    {} BOOLEAN,
                    {} BOOLEAN,
                    {} BOOLEAN,
                    {} BOOLEAN,
                    {} BOOLEAN,
                    {} int(3) not null,
                    {} int(3) not null
                    )""".format(PN, Forename, Surname, YOB, ID, isFW, isGK, isMNGR, isWNR, MP, GD)

cursor.execute(queryCreateTable)

