//
//  ViewController.swift
//  Todoey
//
//  Created by Kjetil Øverby on 27.04.2018.
//  Copyright © 2018 Kjetil Øverby. All rights reserved.
//

import UIKit
import AudioToolbox

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demorgorgon"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = items
        }

    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
    
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
             AudioServicesPlaySystemSound(SystemSoundID(1001))
            
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            AudioServicesPlaySystemSound(SystemSoundID(1007))
            
            
            
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    //MARK - Add New Items
    
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            //What will happen once the user clicks the AddItem button on our UIAlert
           
           self.itemArray.append(textfield.text!)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
         textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)

        
    }
    
    
    
}






