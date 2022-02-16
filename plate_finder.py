"""
A CLI that interactively searches for, downloads, and opens IFR plates
for airports.
"""

import cmd
import os
import requests
from bs4 import BeautifulSoup

ORIGIN_URL = (
    "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products"
    "/dtpp/search/results/"
)

SEARCH_URL = (
    "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/"
)


def make_url(airport_code):
    """
    Makes a URL for the appropriate airport's plates
    """

    return ORIGIN_URL + f"?cycle={cycle}&ident={airport_code}&sort=proc&dir=asc"


def get_plate_objects(url):
    """
    Grabs all the plates from the internet and composes them in a
    helpful and reasonable way
    """

    req = requests.get(url)
    s_content = BeautifulSoup(req.content, "html.parser")

    table = s_content.find_all("tbody")[0]

    rows = table.find_all("tr")

    plate_objects = []

    for row in rows:
        linked_items = row.find_all("a", href=True)
        for link in linked_items:
            plate_objects.append(link)

    for plate in plate_objects:
        if plate.text == "Compare":
            plate_objects.remove(plate)

    return plate_objects


def print_available_plates(plate_objects):
    """
    Gets the list of available plates and prints it
    """

    print_list = []

    for i, obj in enumerate(plate_objects):
        print_list.append(f"{str(i)} {obj.text}")

    print("AVAILABLE PLATES:")
    cli = cmd.Cmd()
    cli.columnize(print_list, displaywidth=80)


def downloadPlate(requested_plate):
    """
    Downloads a plate from the internet and gives it a reasonable name
    """

    response = requests.get(requested_plate["href"])

    with open(requested_plate.text.replace("/", "-") + ".pdf", "wb") as f:
        f.write(response.content)


def open_plate(requested_plate):
    """
    Opens a plate in the default PDF viewer
    """

    plate_name = requested_plate.text.replace("/", "-")
    print(f"Opening {plate_name}.pdf")
    os.system(f"open '{plate_name}.pdf'")


def command_loop(plate_objects):
    """
    Runs the command loop to list plates and open them in a PDF viewer
    """

    should_continue = True
    file_exists = -1

    while should_continue:

        input_string = input("Plate #, Airport code, print or quit: ")

        if file_exists != -1:
            file_name = plate_objects[file_exists].text.replace("/", "-")
            os.system(f"rm '{file_name}.pdf'")

            print(f"deleting {file_name}.pdf")

            file_exists = -1

        if input_string in ("q", "quit"):
            should_continue = False
        elif input_string in ("p", "print"):
            print_available_plates(plate_objects)
        elif input_string.isdigit() and (int(input_string) < len(plate_objects)):
            downloadPlate(plate_objects[int(input_string)])
            open_plate(plate_objects[int(input_string)])
            file_exists = int(input_string)
        elif input_string.isalpha():
            plate_objects = get_plate_objects(make_url(input_string))
            print_available_plates(plate_objects)
        else:
            print("Invalid input")

        print("----------------------")


if __name__ == "__main__":
    c = requests.get(SEARCH_URL)

    soup = BeautifulSoup(c.content, "html.parser")

    cycleOptions = soup.find_all("option")

    cycleValues = []

    for option in cycleOptions:
        cycleValues.append(int(option.get("value")))

    cycle = cycleValues[0]

    startingAirport = input("Airport: ")

    startingPlates = get_plate_objects(make_url(startingAirport))

    print_available_plates(startingPlates)

    command_loop(startingPlates)
