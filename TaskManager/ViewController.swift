//
//  ViewController.swift
//  TaskManager
//
//  Created by Rohith Raju on 24/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items: [String] = ["Apples","Bananas","Cherries","Strawberries"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
                self.items.append(text)
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
        
        return items.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else{

            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

