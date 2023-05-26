//
//  ViewController.swift
//  JPMC_Pratik
//
//  Created by Pratik Patil on 14/05/23.
//

import UIKit

class ViewController: UIViewController {

    let cellIdentifier = "CustomTableViewCell"
 
    @IBOutlet weak var planetTableView: UITableView!
    
    var planetsArray : [Planet]? {
        didSet {
            DispatchQueue.main.async {
                self.planetTableView.reloadData()
            }
        }
    }
    
    var databaseObject = DatabaseHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuring TableView
        planetTableView.delegate = self
        planetTableView.dataSource = self
        planetTableView.tableFooterView = UIView(frame: .zero)
        planetTableView.separatorStyle = .none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() { // Checking Internet Connectivity
            // Clearing Core Data Database Planet
            self.databaseObject.clearData()
            Parser.shared.parseData { // Getting data from server
                self.planetsArray = self.databaseObject.fetchFromCoreData(Planet.self)
            }
        }
        else { // If there is no internet then just accessing the stored data in coredata.
            self.planetsArray = self.databaseObject.fetchFromCoreData(Planet.self)
        }
    }
}

// Using extensions for sorted code.
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetsArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = planetTableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? CustomTableViewCell { // configuring tableViewCell
            cell.planetNameLabel.textAlignment = .center
            cell.planetNameLabel.text = planetsArray?[indexPath.row].name
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
