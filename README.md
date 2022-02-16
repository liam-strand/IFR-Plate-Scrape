# IFR Plate Scrape
[![pylint Score](https://mperlet.github.io/pybadge/badges/10.00.svg)](https://github.com/PyCQA/pylint)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)


## Structure
There are three major components in this repository:
1. The plate_finder.py python script
2. The plateScraperSwift Xcode project
3. Some miscellaneous files that were used to learn how to do
   some of the parts of the scraping process.

## Python Script

### Usage: 
    
    python[3] plate_finder.py


### Does the following:
- Begins a CLI that asks for an airport to view
- When the airport has been selected, the CLI will present the available plates.
- The user can then select a plate to view by entering the plate's number.
- Alternatively, the user can enter an airport code to see a set of plates for the new airport.

### Required Python Libraries:
- cmd
- os
- requests
- [BeautifulSoup](https://pypi.org/project/beautifulsoup4/)


## Swift iOS Application

### Usage:
1. Open the Xcode project using the `.xcodeproj` file.
2. Build the project using Xcode
3. Run it on an iPad simulator

### Does the following:
- Takes input from the user for an airport to view.
- Presents the user with a list of available plates for that airport.
- The user can select a plate to view.
- The user can also enter a new airport to view.

### Required Swift Packages:
- [SwiftSoup](https://github.com/scinfu/SwiftSoup)
