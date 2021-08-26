import requests
from bs4 import BeautifulSoup

r = requests.get("https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/")
soup = BeautifulSoup(r.content, "html.parser")

cycleOptions = soup.find_all("option")

cycleValues = []

for option in cycleOptions:
    cycleValues.append(int(option.get("value")))

print(cycleValues[0])
