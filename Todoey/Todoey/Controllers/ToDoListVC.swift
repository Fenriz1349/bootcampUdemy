//
//  ViewController.swift
//  Todoey
//
//  Created by Julien Cotte on 16/09/2024.
//  Copyright © 2024The App Brewery. All rights reserved.
//

import UIKit
import CoreData

class ToDoListVC: SwipeTableVC {
    
    var itemArray = [Item]()
    
    var selectedCategory: Category? {
        didSet {
            loadItems()
        }
    }
//       permet d'acceder au singleton du persistentContainer declaré dans l'appdelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 50.0
        tableView.separatorStyle = .none
    }
    override func viewDidAppear(_ animated: Bool) {
        title = selectedCategory!.name
        guard let navBar = navigationController?.navigationBar else {
            fatalError("Navigation Controler Does Not Exist")
        }
        navBar.backgroundColor = systemColors[(selectedCategory?.color ?? "systemBlue")]
    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        let item = itemArray[indexPath.row]
        let alphaValue = CGFloat(indexPath.row + 1) / CGFloat(itemArray.count)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        if let colorName = item.parentCategory?.color,
           let baseColor = systemColors[colorName] {
            cell.backgroundColor = baseColor.withAlphaComponent(alphaValue)
        } else {
            // Si la couleur est introuvable, utilise une couleur par défaut
            cell.backgroundColor = UIColor.systemBlue.withAlphaComponent(alphaValue)
        }
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        itemArray[indexPath.row].setValue("Completed", forKey: "title") setValue pour update une valeur
//        attention à l'ordre ! d'abord supprimer du context puis du tableau pour ne pas avoir d'erreur d'index
//        context.delete(itemArray[indexPath.row]) // supprime du context, donc de l'espace de travail temporaire
//        itemArray.remove(at: indexPath.row) // supprime de l'array
        itemArray[indexPath.row].done.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
    }
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
            self.itemArray.append(newItem)
            self.saveItems()
            
            
        }
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
//    save le context permet d'enregistrer dans la vrai database les changement effectués, utilisé pour tout le CRUD sauf le Read
    func saveItems() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems(for request: NSFetchRequest<Item> = Item.fetchRequest(), predicate : NSPredicate? = nil) {
//        permet de faire une requete, il faut specifié l'entité conserné
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let additionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, additionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        let itemToDelete = self.itemArray[indexPath.row]
        self.context.delete(itemToDelete)
        self.itemArray.remove(at: indexPath.row)
        self.saveItems()
        tableView.reloadData()
    }
}

//MARK: - Search Bar methods
extension ToDoListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        //        le predicate est la requete SQlite, elle est pas defaut sensible à la case et aux accents
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        //        le sort descriptor est l'argument de trie, il attend une liste, ils sont executé dans l'ordre de la liste
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(for: request)
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



