//
//  DetailView.swift
//  swiftuitesting
//
//  Created by Liam Strand on 8/26/21.
//

import SwiftUI

struct DetailView: View {
    
    var plate: Plate
    var pdfView: PDFViewUI
    
    var body: some View {
        pdfView
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(plate: K.starterPlates.first!,
                   pdfView: PDFViewUI(url: K.starterPlates.first!.link))
    }
}
