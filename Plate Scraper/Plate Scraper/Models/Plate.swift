//
//  Plate.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/26/21.
//

import Foundation

struct Plate {
    let name: String
    let link: URL
    let id = UUID()
    
    init(_ name: String, _ urlString: String) {
        self.name = name
        self.link = URL(string: urlString)!
    }
    
    init(name: String, link: URL) {
        self.name = name
        self.link = link
    }
}
