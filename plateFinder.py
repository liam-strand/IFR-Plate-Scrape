import requests
from bs4 import BeautifulSoup
import cmd
import os
import time

originURL = "https://flightaware.com"

def makeURL(airportCode):

    return originURL + "/resources/airport/" + airportCode + "/procedures"

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
    
    printList = []
    
    for i in range(len(plateObjects)):
        printList.append("{} {}".format(str(i),plateObjects[i].text))

    print("AVAILABLE PLATES:")
    cli = cmd.Cmd()
    cli.columnize(printList, displaywidth=80)

def downloadPlate(requestedPlate):

    newURL = originURL + requestedPlate["href"] + "/pdf"

    response = requests.get(newURL)

    with open(requestedPlate.text.replace("/", "-") + '.pdf', 'wb') as f:
        f.write(response.content)

def openPlate(requestedPlate):
    print("Opening {}.pdf".format(requestedPlate.text.replace("/", "-")))
    os.system("open \"{}\".pdf".format(requestedPlate.text.replace("/", "-")))


def commandLoop(plateObjects):

    shouldContinue = True
    fileExists = -1

    while shouldContinue:

        inputString = input("Plate, Airport, or quit: ")

        if fileExists != -1:
            print("deleting", fileExists)
            os.system("rm \"{}\".pdf".format(plateObjects[fileExists].text.replace("/", "-")))
            fileExists = -1

        if (inputString == "q" or inputString == "quit"):
            shouldContinue = False
        elif inputString.isdigit() and (int(inputString) < len(plateObjects)):
            downloadPlate(plateObjects[int(inputString)])
            openPlate(plateObjects[int(inputString)])
            fileExists = int(inputString)
        elif inputString.isalpha():
            plateObjects = getPlateObjects(makeURL(inputString))
            printAvailablePlates(plateObjects)
        else:
            print("Invalid input")

        print("----------------------")

startingAirport = input("Airport: ")

startingPlates = getPlateObjects(makeURL(startingAirport))

printAvailablePlates(startingPlates)

commandLoop(startingPlates)