//
//  CategortTableViewController.swift
//  TaskManager
//
//  Created by Rohith Raju on 25/05/18.
//  Copyright © 2018 Rohith Raju. All rights reserved.
//

import UIKit
import CoreData

class CategortTableViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    
    @IBAction func addCategory(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add new category items", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            if let text = textfield.text{
                
                let newCategory = Category(context: self.context)
                
                newCategory.name = text
                
                self.categoryArray.append(newCategory)
                
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
    
    //MARK: - Core data methods
    
    func saveItems(){
        
        do{
            
            try self.context.save()
            
        }catch{
            print("error while saving to coredata:\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    func loadItems(with fetchRequest: NSFetchRequest<Category> = Category.fetchRequest() ){
        
        do{
            try  categoryArray  = self.context.fetch(fetchRequest)
        }catch{
            print("Error in fetching data for Items:\(error)")
        }
        
        tableView.reloadData()
        
    }
    
    

    // MARK: - Tableview delegates
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let category = categoryArray[indexPath.row]
        
        cell.textLabel?.text = category.name
        
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "gotoItems", sender: self)
        
    }
    
    // MARK: - prepare for segure
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
  

}
