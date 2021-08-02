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
    
    func setPlate(plate: Element) {
        do {
            cellLabel.text = try plate.text()
            
        } catch Exception.Error(type: let type, Message: let message) {
            print(type)
            print(message)
        } catch {
            print("oof")
        }
    }
}
