import requests
from bs4 import BeautifulSoup

ogURL = "https://flightaware.com"

r = requests.get(ogURL + "/resources/airport/KBOS/procedures")
soup = BeautifulSoup(r.content, "html.parser")

terminalBlocks = soup(attrs={"class": "medium-1 columns"})

plateObjects = []

for i in range(len(terminalBlocks)):
    for j in terminalBlocks[i]("a", href=True):
        plateObjects.append(j)

for i in range(5):
        print(plateObjects[i]["href"])

newURL = ogURL + plateObjects[0]["href"] + "/pdf"

response = requests.get(newURL)

with open('test.pdf', 'wb') as f:
    f.write(response.content)