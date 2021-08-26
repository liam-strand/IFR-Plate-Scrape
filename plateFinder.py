import requests
from bs4 import BeautifulSoup
import cmd
import os

originURL = "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/results/"


c = requests.get("https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/")
soup = BeautifulSoup(c.content, "html.parser")

cycleOptions = soup.find_all("option")

cycleValues = []

for option in cycleOptions:
    cycleValues.append(int(option.get("value")))

cycle = cycleValues[0]

def makeURL(airportCode):

    return originURL + f"?cycle={cycle}&ident={airportCode}&sort=proc&dir=asc"

def getPlateObjects(url):

    r = requests.get(url)
    soup = BeautifulSoup(r.content, "html.parser")

    table = soup.find_all("tbody")[0]

    rows = table.find_all("tr")

    plateObjects = []

    for row in rows:
        linkedItems = row.find_all("a", href=True)
        for link in linkedItems:
            plateObjects.append(link)

    for o in plateObjects:
        if o.text == "Compare":
            plateObjects.remove(o)

    return plateObjects

def printAvailablePlates(plateObjects):
    
    printList = []
    
    for i in range(len(plateObjects)):
        printList.append("{} {}".format(str(i),plateObjects[i].text))

    print("AVAILABLE PLATES:")
    cli = cmd.Cmd()
    cli.columnize(printList, displaywidth=80)

def downloadPlate(requestedPlate):

    response = requests.get(requestedPlate["href"])

    with open(requestedPlate.text.replace("/", "-") + '.pdf', 'wb') as f:
        f.write(response.content)

def openPlate(requestedPlate):
    print("Opening {}.pdf".format(requestedPlate.text.replace("/", "-")))
    os.system("open \"{}\".pdf".format(requestedPlate.text.replace("/", "-")))


def commandLoop(plateObjects):

    shouldContinue = True
    fileExists = -1

    while shouldContinue:

        inputString = input("Plate #, Airport code, print or quit: ")

        if fileExists != -1:
            os.system("rm \"{}\".pdf".format(plateObjects[fileExists].text.replace("/", "-")))

            print("deleting", plateObjects[fileExists].text.replace("/", "-"))

            fileExists = -1

        if (inputString == "q" or inputString == "quit"):
            shouldContinue = False
        elif (inputString == "p" or inputString == "print"):
            printAvailablePlates(plateObjects)
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