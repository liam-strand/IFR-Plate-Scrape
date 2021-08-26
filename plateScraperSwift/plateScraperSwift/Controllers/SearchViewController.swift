//
//  SearchViewController.swift
//  plateScraperSwift
//
//  Created by Liam Strand on 8/2/21.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBox: UITextField!
    
    let requestManager = RequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBox.delegate = self
        searchBox.becomeFirstResponder()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: K.SegueIDs.ListView, sender: self)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: K.SegueIDs.ListView, sender: self)
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ListViewController {
            destination.search = searchBox.text ?? ""
            destination.plateElements = requestManager.createArray(cycle: requestManager.getCycle(), airport: searchBox.text ?? "")
            destination.plateTableView.reloadData()
            destination.title = searchBox.text ?? ""
            if K.Debug.printSearch { print(searchBox.text ?? "no text") }
        }
    }

}
