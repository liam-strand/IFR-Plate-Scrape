//
//  ListView.swift
//  Plate Scraper
//
//  Created by Liam Strand on 8/26/21.
//

import SwiftUI

struct ListView: View {
    var plates: [Plate]?
    
    @State private var showingPopover = false
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            List(plates ?? K.starterPlates, id: \.id) { plate in
                NavigationLink(
                    destination: DetailView(plate: plate, pdfView: PDFViewUI(url: plate.link)),
                    label: {
                        Text(plate.name)
                    })
            }
            
            .navigationTitle("KACK")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Search New Plates", action: {
                        print("button pressed")
                        print(searchText)
                        showingPopover = true
                    })
                    .popover(isPresented: $showingPopover) {
                        SearchBarView(text: $searchText)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(plates: K.starterPlates)
    }
}
