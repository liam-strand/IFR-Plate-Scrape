//
//  ViewController.swift
//  testing
//
//  Created by Liam Strand on 8/26/21.
//

import UIKit
import SwiftSoup

struct Plate {
    let link: URL
    let name: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cycle = 2108
        let airport = "kack"
        
        var plates: [Plate] = []
        
        do {
            let url = URL(string: "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/results/?cycle=\(cycle)&ident=\(airport)&sort=proc&dir=asc")!
            
            print(url)
            
            let html = try String(contentsOf: url, encoding: String.Encoding.ascii)
            
            let doc: Document = try SwiftSoup.parse(html)
            
            let table = try doc.getElementsByTag("tr")
            
            
            for row in table {
                let plateObject: Elements = try row.getElementsByAttribute("href")

                plates.append(Plate(link: try URL(string: plateObject.attr("href"))!, name: try plateObject.text()))
            }
            
            for plate in plates {
                print("\(plate.name) : \(plate.link)")
            }
            
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        
        exit(EXIT_SUCCESS)
    }
}

