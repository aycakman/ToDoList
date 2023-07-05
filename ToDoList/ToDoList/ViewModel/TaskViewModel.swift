//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Ayca Akman on 3.07.2023.
//

import Foundation

protocol TaskViewModelInterface {
    var view: TaskViewInterface? { get set }
    
    func viewDidLoad()
    func loadTasks()
    func saveTasks()
    func addTasks(with title : String)
    func deleteTasks(at index: Int)
    func completeTasks(at index: Int)
    func numberOfTasks() -> Int
    func taskTitle(at index: Int) -> String
    func isTaskCompleted(at index: Int) -> Bool

}

final class TaskViewModel {
    weak var view: TaskViewInterface?
    
    private var tasks = [Task]()
    
    let userDefaults = UserDefaults.standard

}

extension TaskViewModel: TaskViewModelInterface {
    
    func viewDidLoad() {
        view?.prepareTableView()
    }
    
    func loadTasks() {
        if let data = userDefaults.data(forKey: "Tasks"),
           let savedTasks = try? JSONDecoder().decode([Task].self, from: data) {
            tasks = savedTasks
            view?.reloadTasks()
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
        view?.reloadTasks()
        saveTasks()
    }
    
    func deleteTasks(at index: Int) {
        tasks.remove(at: index)
        view?.reloadTasks()
        saveTasks()
    }
    
    func completeTasks(at index: Int) {
        tasks[index].isCompleted.toggle()
        view?.reloadTasks()
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
