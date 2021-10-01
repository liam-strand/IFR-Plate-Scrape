//
//  ListView.swift
//  swiftuitesting
//
//  Created by Liam Strand on 8/26/21.
//

import SwiftUI

struct ListView: View {
    
    @State private var plates: [Plate] = []
    
    @State private var showingPopover = false
    
    @State private var searchText = ""
    
    @State private var title = "KACK"
    
    var body: some View {
        NavigationView {
            List(plates, id: \.id) { plate in
                NavigationLink(
                    destination: DetailView(plate: plate, pdfView: PDFViewUI(url: plate.link)),
                    label: {
                        Text(plate.name)
                    }
                )
            }
            
            .navigationTitle(searchText)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Search New Plates", action: {
                        print(searchText)
                        showingPopover = true
                    })
                    .popover(isPresented: $showingPopover) {
                        SearchBarView(text: $searchText, plates: $plates, isPresented: $showingPopover)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
