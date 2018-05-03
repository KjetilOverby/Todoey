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

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
      if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
      }

    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        
       
        cell.accessoryType = item.done ? .checkmark : .none
      
   
        
        
        return cell
        
    }
    
    //MARK - Tableview delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
    
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
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
            
            let newItem = Item()
            newItem.title = textfield.text!
           
           self.itemArray.append(newItem)
            
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






