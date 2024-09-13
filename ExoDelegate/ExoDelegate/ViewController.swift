//
//  ViewController.swift
//  ExoDelegate
//
//  Created by Julien Cotte on 10/09/2024.
//

import UIKit

class ViewController: UIViewController {

    
    var taskManager = TaskManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskManager.delegate = self
        taskManager.addTask()
        taskManager.addTask()
        taskManager.addTask()
        print(taskManager.taskList)
    }

    

}

extension ViewController : TaskManagerDelegate {
    func taskAdded(_ manager: TaskManager) {
        print("The task is added to the list")
    }
        
    
}
