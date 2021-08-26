//
//  ViewController.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/1/21.
//

import UIKit
import SwiftSoup
import PDFKit

class PDFViewController: UIViewController {
    
    let requestManager = RequestManager()
    
    var requestedPlate: Plate?
    var airportCode: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfView = setupPDFView()
        
        self.title = airportCode + ": " +  requestedPlate!.name
        
        let url = requestedPlate!.link
        
        pdfView.document = PDFDocument(url: url)

        
    }
    
    func setupPDFView() -> PDFView{
        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(pdfView)
        
        pdfView.autoScales = true
        
        return pdfView
    }
    

}

