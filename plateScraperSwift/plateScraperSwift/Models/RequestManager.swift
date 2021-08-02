//
//  RequestManager.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/2/21.
//

import Foundation
import SwiftSoup

class RequestManager {
    
    func createArray(airport: String) -> [Element] {
        
        var plates: [Element] = []
        
        do {
            let url = URL(string: K.URLs.airportLookupBeginning + airport + K.URLs.airportLookupEnd) ?? URL(string: K.URLs.origin)!
            
            if K.Debug.printSearchURL { print(url.absoluteString) }
            
            let html = try String(contentsOf: url, encoding: String.Encoding.ascii)
            
            let doc: Document = try SwiftSoup.parse(html)
            
            let blocks = try doc.getElementsByClass(K.HTMLData.dataColumns)
            
            for block in blocks {
                plates.append(contentsOf: try block.getElementsByTag(K.HTMLData.rowTag))
            }
            
            if K.Debug.printPlateList {
                for plate in plates {
                    print(try plate.text())
                }
            }
            
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        return plates
    }
    
    func getPDFLink(_ requestedPlate: Element?) -> URL {
        do {
            
            let linkExtension: String = try requestedPlate!.attr(K.HTMLData.linkAttr)
            
            let newURL: URL = URL(string: K.URLs.origin + linkExtension + K.URLs.pdfEnd)!
            
            if K.Debug.printPDFLink { print(newURL) }
            
            return newURL
            
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        return URL(string: K.URLs.origin)!
    }
    
    func getText(_ object: Element) -> String {
        
        do {
            return try object.text()
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
        
        return ""
        
    }
    
}
