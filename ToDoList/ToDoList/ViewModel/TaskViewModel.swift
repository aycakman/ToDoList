//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Ayca Akman on 3.07.2023.
//

import Foundation

class TaskViewModel {
    
    private var tasks = [Task]()
    
    let userDefaults = UserDefaults.standard
    
    var reloadTasks: (() -> Void)?
    
    func loadTasks() {
        if let data = userDefaults.data(forKey: "Tasks"),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = savedTasks
            reloadTasks?()
        }
    }
    
    func saveTasks() {
        if let data = try? JSONEncoder().encode(tasks) {
            userDefaults.set(data, forKey: "Tasks")
        }
    }
    
    func addTasks(with title : String) {
        let newTask = Task(title: title, isCompleted: false)
        tasks.append(newTask)
        reloadTasks?()
        saveTasks()
    }

    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
        reloadTasks?()
        saveTasks()
    }
    
    func numberOfTasks() -> Int {
        return tasks.count
    }
    
    func taskTitle(at index: Int) -> String {
        return tasks[index].title
    }
    
    func isTaskCompleted(at index: Int) -> Bool {
        return tasks[index].isCompleted
    }
}
