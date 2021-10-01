//
//  RequestManager.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/2/21.
//

import Foundation
import SwiftSoup

class RequestManager {
    
    func getCycle() -> Int {
        let url = URL(string: "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/")!
        print("3")
        var cycle = 2108
        
        do {
            let html = try String(contentsOf: url, encoding: String.Encoding.ascii)
            
            let doc: Document = try SwiftSoup.parse(html)
            
            let cycleOptions: Elements = try doc.getElementsByTag(K.HTMLData.cycleSelector)
            
            let cycleObject: Element = cycleOptions[0]
            
            if K.Debug.printCycle { print(try cycleObject.attr(K.HTMLData.cycleData)) }
            
            cycle = Int(try cycleObject.attr(K.HTMLData.cycleData)) ?? 2108
            print("4")
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        
        return cycle
    }
    
    func createArray(cycle: Int, airport: String) -> [Plate] {
        print("5")
        var plates: [Plate] = []
        
        do {
            let url = URL(string: "https://www.faa.gov/air_traffic/flight_info/aeronav/digital_products/dtpp/search/results/?cycle=\(cycle)&ident=\(airport)&sort=proc&dir=asc")!
            
            if K.Debug.printSearchURL{ print(url) }
            
            let html = try String(contentsOf: url, encoding: String.Encoding.ascii)
            
            let doc: Document = try SwiftSoup.parse(html)
            
            let table = try doc.getElementsByTag(K.HTMLData.rowTag)
            
            print("6")
            for row in table {
                let plateObject: Elements = try row.getElementsByAttribute(K.HTMLData.linkAttr)
                
                let newPlate = Plate(name: try plateObject.text().replacingOccurrences(of: K.HTMLData.compare, with: ""),
                                     link: try URL(string: plateObject.attr(K.HTMLData.linkAttr))!)
                
                plates.append(newPlate)
            }
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        print("7")
        plates.remove(at: 0)
                
        if K.Debug.printSearch {
            for plate in plates {
                print("\(plate.name) : \(plate.link)")
            }
        }
        print("8")
        return plates
    }
}
