import requests
from bs4 import BeautifulSoup
import pprint

def makeURL(airport):
    return "https://flightaware.com/resources/airport/" + airport + "/procedures"

def getPlateObjects(url):

    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html.parser")

    terminalBlocks = soup.find_all(attrs={"class": "medium-1 columns"})

    plateObjects = []

    for i in range(len(terminalBlocks)):
        for j in terminalBlocks[i].find_all("a"):
            plateObjects.append(j)
    
    return plateObjects

def printAvailablePlates(plateObjects):
    for i in range(len(plateObjects)):
        print(plateObjects[i].text)

printAvailablePlates(getPlateObjects(makeURL("KLAX")))