import requests
from bs4 import BeautifulSoup

url = "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/results/?cycle=2108&ident=kack&sort=proc&dir=asc"

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

for o in plateObjects:
    print(o.text)