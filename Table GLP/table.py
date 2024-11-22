#-------------------------------------------------------------------------------
# Name:        Table
# Purpose:     simulate a WFLP League table
#
# Author:      akob
# Version:     1.00
# Created:     17/11/2020
# Copyright:   (c) akob 2020
# Licence:     <your licence>
#-------------------------------------------------------------------------------



class Table():

    def __init__(self, place, team, m, w, d, l, g, p, last_game):
        self.place = place
        self.team = team
        self.matches = m
        self.won = w
        self.draw = d
        self.lost = l
        self.goals = g
        self.points = p
        self.last_game = last_game

    def setPlace(self, newplace):
        self.place = newplace
    def getPlace(self):
        return self.place

    def setTeam(self, newteam):
        self.team = newteam
    def getTeam(self):
        return self.team

    def setMatches(self, newm):
        self.matches = newm
    def getMatcehs(self):
        return self.matches

    def setWon(self, neww):
        self.won = neww
    def getWon(self):
        return self.won

    def setDraw(self, newd):
        self.draw = newd
    def getDraw(self):
        return self.draw

    def setLost(self, newl):
        self.lost = newl
    def getLost(self):
        return self.lost

    def setGoals(self, ne):
        self.goals = newg
    def getGoals(self):
        return self.goals

    def setPoints(self, newp):
        self.points = newp
    def getPoints(self):
        return self.points

    def setLast_game(self, newlast_game):
        self.last_game = newlast_game
    def getLast_game(self):
        return sels.last_game


    def toString(self):
        #a method to return ALL attribute values to string
        string = str(self.place) + " " + str(self.team) + " " + str(self.matches) + " " + str(self.won)
        string2 = " " + str(self.draw) + " " + str(self.lost) + " " + str(self.goals) + " " + str(self.points) + " " + str(self.last_game)
        output = str(string) + str(string2)
        return output
