//
//  testArray.swift
//  swiftuitesting
//
//  Created by Liam Strand on 8/26/21.
//

import Foundation

struct Plate: Identifiable {
    let name: String
    let link: URL
    let id = UUID()
    
    init(_ name: String, _ link: String) {
        self.name = name
        self.link = URL(string: link)!
    }
}


let plateData: [Plate] = [
    Plate("A/FD HOT SPOT",
          "http://aeronav.faa.gov/afd/12Aug2021/ne_hotspot.pdf"),
    Plate("AIRPORT DIAGRAM",
          "http://aeronav.faa.gov/d-tpp/2108/00659ad.pdf#nameddest=(ACK)"),
    Plate("ALTERNATE MINIMUMS",
          "http://aeronav.faa.gov/d-tpp/2108/ne1alt.pdf#nameddest=(ACK)"),
    Plate("DEEPO ONE (RNAV)",
          "http://aeronav.faa.gov/d-tpp/2108/00659deepo.pdf#nameddest=(ACK)"),
    Plate("GREAT POINT VISUAL RWY 24",
          "http://aeronav.faa.gov/d-tpp/2108/00659greatpoint_vis24.pdf#nameddest=(ACK)"),
    Plate("HOT SPOT",
          "http://aeronav.faa.gov/d-tpp/2108/ne1hotspot.pdf#nameddest=(ACK)")
]
