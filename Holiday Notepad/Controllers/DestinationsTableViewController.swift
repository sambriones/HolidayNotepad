//
//  DestinationsTableViewController.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 24/1/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import CoreData


class DestinationsTableViewController: UITableViewController {
    
    var destinations = [Destination]()
    
    var selectedCity : Destination?
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
    loadItems()
    
        
    

       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return destinations.count
    }

    // MARK: Table view Delegate Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "destinationCell", for: indexPath)
        
        cell.textLabel?.text = destinations[indexPath.row].cityName
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCity = destinations[indexPath.row]
        performSegue(withIdentifier: "goToActivity", sender: self)
    }
    
    
    func saveItems() {
        do {
            try context.save()
        } catch {
             print("Error saving context \(error)")
     
        }
    }
    
    func loadItems(with request: NSFetchRequest<Destination> = Destination.fetchRequest() , predicate: NSPredicate? = nil ){
            

            
            do {
                destinations = try context.fetch(request)
                tableView.reloadData()
            } catch {
                print("Error fetching data from context \(error)")
            }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let destinationVC =  segue.destination as! ActivityTableViewController
    
    if let indexPath = tableView.indexPathForSelectedRow {
        destinationVC.selectedCity = destinations[indexPath.row]
      
    }
    
    
        // Pass the selected object to the new view controller.
    }
 
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New City", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add City", style: .default) { (action) in
            
            let newCity = Destination(context: self.context)
            newCity.cityName = textField.text
            self.destinations.append(newCity)
            
            self.saveItems()
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
    

