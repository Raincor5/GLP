import mysql.connector

mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='GLPadmin',
    database='GLP_table_db'
)
print(mydb)


cursor = mydb.cursor()
cursor.execute("CREATE DATABASE glp_table_db")
cursor.execute('SHOW DATABASES')

