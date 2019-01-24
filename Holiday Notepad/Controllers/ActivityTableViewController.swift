//
//  ActionsTableViewController.swift
//  Holiday Notepad
//
//  Created by Jessamine Briones on 24/1/19.
//  Copyright © 2019 Jessamine Briones. All rights reserved.
//

import UIKit
import CoreData


class ActivityTableViewController: UITableViewController {
    
    var activityArray = [ "Essential Information" , " To Do " , " To See " , " To Eat " , "To Buy" ]
    
    var selectedCity : Destination?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
        cell.textLabel?.text = activityArray[indexPath.row]
        

        return cell
    }
      // MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "items", sender: self)
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let destinationVC = segue.destination as! ItemViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedActivity = indexPath.row
            destinationVC.title = activityArray[indexPath.row]
            destinationVC.selectedCity = self.selectedCity
        }
    }

}
    


