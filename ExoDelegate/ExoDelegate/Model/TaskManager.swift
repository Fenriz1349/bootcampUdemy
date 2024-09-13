//
//  DownloadManager.swift
//  ExoDelegate
//
//  Created by Julien Cotte on 10/09/2024.
//

import Foundation

protocol TaskManagerDelegate {
    
    func taskAdded(_ manager: TaskManager)
}

class TaskManager {
    
    var delegate : TaskManagerDelegate?
    
    var count = 0
    var taskList : [String] = []
    
    func addTask() {
        count += 1
        print("Adding task \(count)")
        taskList.append("Task \(count)")
        delegate?.taskAdded(self)
    }
}
