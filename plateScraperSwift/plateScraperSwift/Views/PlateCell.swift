//
//  PlateCellTableViewCell.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/1/21.
//

import UIKit
import SwiftSoup

class PlateCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    func setPlate(plate: Plate) {
        cellLabel.text = plate.name
    }
}
