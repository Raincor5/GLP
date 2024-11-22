#-------------------------------------------------------------------------------
# Name:        Table test
# Purpose:     test a WFLP League table
#
# Author:      akob
# Version:     1.00
# Created:     17/11/2020
# Copyright:   (c) akob 2020
# Licence:     <your licence>
#-------------------------------------------------------------------------------


from table import Table
from tabulate import tabulate




Algeti = Table(1,"Algeti",1,1,0,0,1-0,3,"Win")
Amkal = Table(1,"Amkal",1,1,0,0,1-0,3,"Win")
Blancos = Table(1,"Blancos United",1,1,0,0,1-0,3,"Win")
Dinamo = Table(1,"Dinamo Tbilisi",1,1,0,0,1-0,3,"Win")
Gardabani = Table(1,"Gardabani",1,1,0,0,1-0,3,"Win")
Melomania = Table(1,"Melomania",1,1,0,0,1-0,3,"Win")
Rioni = Table(1,"Rioni",1,1,0,0,1-0,3,"Win")
Rubin = Table(1,"Rubin",1,1,0,0,1-0,3,"Win")
Saburtalo = Table(1,"Saburtalo",1,1,0,0,1-0,3,"Win")
Shark = Table(1,"Shark Team",1,1,0,0,1-0,3,"Win")
Zenit = Table(1,"Zenit",1,1,0,0,1-0,3,"Win")
Zugdidi = Table(1,"Zugdidi",1,1,0,0,1-0,3,"Win")
teams = [Algeti, Amkal, Blancos, Dinamo, Gardabani, Melomania, Rioni, Rubin,
Saburtalo, Shark, Zenit, Zugdidi]
"""

Blancos 3 2 Algeti Zugdidi 2 5 Gardabani Amkal 5 2 Dinamo Shark 0 3 Rubin Zenit 2 2 Saburtalo Rioni 3 0 Melomania

"""
input_string = input("Enter a list elements separated by space ")
userList = input_string.split()

print("user list is ", userList)

if userList[0] in teams :
    print("da")


print (teams[0])


win = input("Did Algeti win?")
if win == "y":
    Algeti.place = Algeti.place + 3



table = [
[Algeti.place,Algeti.team,Algeti.matches,Algeti.won,Algeti.draw,Algeti.lost,Algeti.points,Algeti.last_game],
[Amkal.place,Amkal.team,Amkal.matches,Amkal.won,Amkal.draw,Amkal.lost,Amkal.points,Amkal.last_game],
[Blancos.place,Blancos.team,Blancos.matches,Blancos.won,Blancos.draw,Blancos.lost,Blancos.points,Blancos.last_game],
[Dinamo.place,Dinamo.team,Dinamo.matches,Dinamo.won,Dinamo.draw,Dinamo.lost,Dinamo.points,Dinamo.last_game],
[Gardabani.place,Gardabani.team,Gardabani.matches,Gardabani.won,Gardabani.draw,Gardabani.lost,Gardabani.points,Gardabani.last_game],
[Melomania.place,Melomania.team,Melomania.matches,Melomania.won,Melomania.draw,Melomania.lost,Melomania.points,Melomania.last_game],
[Rioni.place,Rioni.team,Rioni.matches,Rioni.won,Rioni.draw,Rioni.lost,Rioni.points,Rioni.last_game],
[Rubin.place,Rubin.team,Rubin.matches,Rubin.won,Rubin.draw,Rubin.lost,Rubin.points,Rubin.last_game],
[Saburtalo.place,Saburtalo.team,Saburtalo.matches,Saburtalo.won,Saburtalo.draw,Saburtalo.lost,Saburtalo.points,Saburtalo.last_game],
[Shark.place,Shark.team,Shark.matches,Shark.won,Shark.draw,Shark.lost,Shark.points,Shark.last_game],
[Zenit.place,Zenit.team,Zenit.matches,Zenit.won,Zenit.draw,Zenit.lost,Zenit.points,Zenit.last_game],
[Zugdidi.place,Zugdidi.team,Zugdidi.matches,Zugdidi.won,Zugdidi.draw,Zugdidi.lost,Zugdidi.points,Zugdidi.last_game],
]
print(tabulate(table))


with open('listfile.txt', 'w') as filehandle:
    for listitem in table:
        filehandle.write('%s\n' % listitem)
