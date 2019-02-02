//
//  DestinationsTableViewController.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 24/1/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework


class DestinationsTableViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var destinations: Results<Destination>?
    
    var selectedCity : Destination?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDestinations()
        
        tableView.separatorStyle = .none
        
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return destinations.count
    //    }
    
    // MARK: Table view Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath )
        
        if let destination = destinations?[indexPath.row] {
            
            cell.textLabel?.text = destination.cityName
        }
            
        guard let destinationColour = UIColor(hexString: destination.colour) else {fatalError()}
        cell.backgroundColor = destinationColour
        cell.textLabel?.textColor = ContrastColorOf(destinationColour, returnFlat:  true)
            
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToActivity", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC =  segue.destination as! ActivityTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCity = destinations?[indexPath.row]
            
        }
    }
    
    
    func save(destination: Destination) {
        do {
            try realm.write {
                realm.add(destination)
            }
        } catch {
            print("Error saving context \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadDestinations() {
        
       destinations = realm.objects(Destination.self)
       
        tableView.reloadData()
       
    }
    
    // MARK: Delete data from Swipe
    
    override func updateModel(at indexPath: IndexPath) {
        if let destinationForDeletion = self.destinations?[indexPath.row] {
            
            do {
                
                try self.realm.write {
                    self.realm.delete(destinationForDeletion)
                }
                
            } catch {
                print("Error deleting category, \(error)")
            }
        }
    }
    
    
    // MARK: - Navigation

    // Pass the selected object to the new view controller.

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New City", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add City", style: .default) { (action) in
            
            let newCity = Destination()
            newCity.cityName = textField.text!
            newCity.colour = UIColor.randomFlat.hexValue()
           
            
            self.save(destination: newCity)
            self.tableView.reloadData()
            
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a new city "
            textField = alertTextField
            
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}


