//
//  ViewController.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 24/1/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UITableViewController {
    var itemArray = [Item]()
    
    var selectedActivity: Int?
    
    var selectedCity : Destination?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self.selectedActivity)
        // why did you put this?
    }
    
    // MARK: Tableview Data Source Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
       
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
      // MARK: Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest() , predicate: NSPredicate? = nil ){
        
        let cityPredicate = NSPredicate(format: "parentCategory.cityName MATCHES %@" ,selectedCity!.cityName! )
        let typePredicate = NSPredicate(format: "type == %ld", self.selectedActivity!)

        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [typePredicate, cityPredicate])


        do {
            itemArray = try context.fetch(request)
            tableView.reloadData()
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }
    
    func saveItems() {
        
        do{
            try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
    }


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle:.alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item(context: self.context)
            newItem.title = textField.text
            newItem.done = false
            newItem.parentCategory = self.selectedCity
            newItem.type = Int16(self.selectedActivity!)
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            // extending the scope of the alertTextField by assigning var textField to it
        }
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

// MARK: Data Source
extension ItemViewController: UISearchBarDelegate {
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
         }
    }
    
}




