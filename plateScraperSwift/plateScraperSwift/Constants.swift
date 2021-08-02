//
//  Constants.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/2/21.
//

import Foundation

struct K {
    
    struct Debug {
        static let printPlateList = true
        static let printPDFLink = true
        static let printSearch = true
        static let printSearchURL = true
    }
    
    struct SegueIDs {
        static let PDFView = "goToPDFView"
        static let ListView = "unwindToList"
        static let SearchView = "goToSearch"
    }
    
    struct ObjectIDs {
        static let plateCell = "PlateCell"
    }
    
    struct URLs {
        static let origin = "https://flightaware.com"
        static let airportLookupBeginning = "https://flightaware.com/resources/airport/"
        static let airportLookupEnd = "/procedures"
        static let pdfEnd = "/pdf"
    }
    
    struct HTMLData {
        static let dataColumns = "medium-1 columns"
        static let rowTag = "a"
        static let linkAttr = "href"
    }
    
    static let startupTitle = "Tap on the search icon to request an airport's plates"
}
