//
//  ViewController.swift
//  TaskManager
//
//  Created by Rohith Raju on 24/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var itemsArray = [Item]()
    
    var defaults = UserDefaults.standard
    
  
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        // Do any additional setup after loading the view, typically from a nib.
        
        let item = Item(title: "Apples")
        let item1 = Item(title: "Bananas")
        let item2 = Item(title: "Cherries")
        let item3 = Item(title: "Strawberries")
        
        itemsArray.append(item)
        itemsArray.append(item1)
        itemsArray.append(item2)
        itemsArray.append(item3)

//        if let itemsDef = defaults.array(forKey: "itemsArray") as? [Item] {
//            self.itemsArray = itemsDef
//        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Action
    
    @IBAction func addItem(_ sender: Any) {
       
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new task items", message: "", preferredStyle: .alert)
       
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let text = textfield.text{
                
                let newItem = Item(title: text)
                self.itemsArray.append(newItem)
             //   self.defaults.setValue(self.itemsArray, forKey: "itemsArray")

                self.tableView.reloadData()
                

            }
            
        }
        
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder = "Create new item"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Tableview delegates

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemsArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let item = itemsArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let item = itemsArray[indexPath.row]
        
         item.done = !item.done
        
        self.tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

