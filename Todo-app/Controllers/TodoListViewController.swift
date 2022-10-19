//
//  ViewController.swift
//  Todo-app
//
//  Created by Infinity Code on 10/13/22.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    // MARK: - Tableview Datasource Methods // How to display data in a tableView(UITableView) in Swift
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            
            cell.accessoryType = item.done == true ? .checkmark : .none
        } else {
            cell.textLabel?.text = "🚧 NO ITEMS ADDED ☝️"
        }
        
        
        return cell
    }
    
    
    // MARK: - TableView Delegate Methods // How to detect table view cell touched or clicked in Swift
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = todoItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
            }
            
            } catch {
                print("Error saving done status, \(error)")
            }
        }
        
        tableView.reloadData()
        // toggle done check mark
        
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        //        todoItems[indexPath.row].done = !todoItems[indexPath.row].done
        
        //        saveItems()
        
        // deselects row with a animation
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Add new items button
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item 😄", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.selectedCategory {
                
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
                
            }
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextFiled) in
            alertTextFiled.placeholder = "Create new Item"
            textField = alertTextFiled
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Model Manipulation Methods

    func loadItems() {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
    
}


// MARK: - Search Bar Methods

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        let request : NSFetchRequest<Item> = Item.fetchRequest()
        //
        //        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        //
        //        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        //
        //        if searchBar.text == "" {
        //            loadItems()
        //
        //            DispatchQueue.main.async {
        //                searchBar.resignFirstResponder()
        //            }
        //
        //        } else {
        //            loadItems(with: request, predicate: predicate)
        //        }
        
    }
    
    
}
