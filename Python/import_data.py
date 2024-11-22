import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='GLPadmin',
    database='GLP_table_db',
    buffered= True
)
print(mydb)


cursor = mydb.cursor()
cursor.execute('SHOW DATABASES')

f = open('F:\GLP\Python\Teams\Blancos United\BUplayers.csv')
fString = f.read()

fList = []
for line in fString.split('\n'):
    fList.append(line.split(','))

print(fList)

del fList[0]

rows = ''

for i in range(len(fList)-1):
     rows += "('{}','{}','{}','{}','{}','{}','{}','{}','{}','{}','{}')"\
         .format(fList[i][0], fList[i][1], fList[i][2], fList[i][3], fList[i][4],
                 fList[i][5], fList[i][6], fList[i][7], fList[i][8], fList[i][9], fList[i][10])

     if i != len(fList)-2:
         rows += ','

print(rows)
queryInsert = "INSERT INTO BLANCOSPLAYERS VALUES" + rows

cursor.execute(queryInsert)
mydb.commit()