//
//  Constants.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/2/21.
//

import Foundation

struct K {
    
    struct Debug {
        static let printPlateList = false
        static let printPDFLink = false
        static let printSearch = false
        static let printSearchURL = false
        static let printCycle = false
    }
    
    struct SegueIDs {
        static let PDFView = "goToPDFView"
        static let ListView = "unwindToList"
        static let SearchView = "goToSearch"
    }
    
    struct ObjectIDs {
        static let plateCell = "PlateCell"
    }
    
    struct HTMLData {
        static let cycleSelector = "option"
        static let cycleData = "value"
        static let rowTag = "tr"
        static let linkAttr = "href"
        static let compare = " Compare"
    }
    
    static let startupTitle = "Tap on the search icon to request an airport's plates"
    
    static let starterPlates = [Plate("AIRPORT DIAGRAM", "http://aeronav.faa.gov/d-tpp/2108/00659ad.pdf#nameddest=(ACK)")]
}
