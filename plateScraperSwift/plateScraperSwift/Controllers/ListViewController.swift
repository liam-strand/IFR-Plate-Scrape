//
//  TableViewController.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/1/21.
//

import UIKit
import SwiftSoup

class ListViewController: UIViewController {
    
    @IBOutlet weak var plateTableView: UITableView!
    
    var plateElements: [Plate] = []
    var search: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSearchButton()
        
        self.title = K.startupTitle
        
        plateTableView.delegate = self
        plateTableView.dataSource = self
    }
    
    func createSearchButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTapped))
    }
    
    @objc func searchTapped() {
        performSegue(withIdentifier: K.SegueIDs.SearchView, sender: self)
    }
    
    
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
    }
    
}

//MARK: - TableView Extension
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plateElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let plate = plateElements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.ObjectIDs.plateCell) as! PlateCell
        
        cell.setPlate(plate: plate)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.SegueIDs.PDFView, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PDFViewController {
            destination.requestedPlate = plateElements[plateTableView.indexPathForSelectedRow!.row]
            plateTableView.deselectRow(at: plateTableView.indexPathForSelectedRow!, animated: true)
            destination.airportCode = search
        }
    }
    
}
