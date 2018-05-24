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
    
    //var defaults = UserDefaults.standard
    
   let dataFilePath = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         loadItems()
     

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

                self.saveItems()
                

            }
            
        }
        
        alert.addTextField { (alertTextField) in
        
            alertTextField.placeholder = "Create new item"
            textfield = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Data conversion using NSCoder
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemsArray)
            
            try data.write(to: dataFilePath!)
            
        }catch{
            
            print("error saving data: \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            
            let decoder = PropertyListDecoder()
            do{
                itemsArray = try decoder.decode([Item].self, from: data)

            }catch{
                
                print("Error decoding data:\(error)")
                
            }
        }
        
        
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
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

