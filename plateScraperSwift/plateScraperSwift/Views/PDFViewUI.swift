//
//  PDFViewUI.swift
//  swiftuitesting
//
//  Created by Liam Strand on 8/26/21.
//

import UIKit
import SwiftUI
import PDFKit

struct PDFViewUI : UIViewRepresentable {
    
    var url: URL?
    
    func makeUIView(context: Context) -> UIView {
        let pdfView = PDFView()
        pdfView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        
        if let url = url {
            pdfView.document = PDFDocument(url: url)
        }
        
        return pdfView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Empty
    }
    
}
