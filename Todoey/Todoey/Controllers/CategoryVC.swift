//
//  CategoryVC.swift
//  Todoey2
//
//  Created by Julien Cotte on 17/09/2024.
//

import UIKit
import CoreData

class CategoryVC: SwipeTableVC {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.rowHeight = 80.0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        cell.backgroundColor = systemColors[categoryArray[indexPath.row].color ?? "systemBlue"] ?? .systemBlue
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) { action in

            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            newCategory.color = self.getRandomSystemColorName()
            self.categoryArray.append(newCategory)
            self.saveCategories()
        }
        alert.addTextField{ alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
            
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveCategories() {
        do {
            try context.save()
        } catch {
            print("error saving context \(error)")
        }
        tableView.reloadData()
    }
    
    func loadCategories(for request: NSFetchRequest<Category> = Category.fetchRequest()) {
//        permet de faire une requete, il faut specifié l'entité conserné
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    override func updateModel(at indexPath: IndexPath) {
        let categoryToDelete = self.categoryArray[indexPath.row]
        self.context.delete(categoryToDelete)
        self.categoryArray.remove(at: indexPath.row)
        self.saveCategories()
        tableView.reloadData()
    }
    
    func getRandomSystemColorName() -> String {
        
        return systemColors.keys.randomElement() ?? "systemBlue"
    }
}


