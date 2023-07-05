//
//  ViewController.swift
//  ToDoList
//
//  Created by Ayca Akman on 3.07.2023.
//

import UIKit

protocol TaskViewInterface: AnyObject {
    func prepareTableView()
    func reloadTasks()
    func addTaskAlert()
}

final class ViewController: UIViewController {

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var addButton: UIBarButtonItem!
    
    private lazy var viewModel = TaskViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        viewModel.addButtonPressed()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.completeTasks(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTasks(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        let title = viewModel.taskTitle(at: indexPath.row)
        let isCompleted = viewModel.isTaskCompleted(at: indexPath.row)
        cell.titleLabel?.text = title
        cell.accessoryType = isCompleted ? .checkmark : .none
        /*
         let accessoryType = viewModel.completedResult(at: indexPath.row)
         switch accessoryType {
         case .checkmark:
             cell.accessoryType = .checkmark
         case .none:
             cell.accessoryType = .none
         }
         */
        return cell
    }
}



extension ViewController: TaskViewInterface {
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.loadTasks()
    }
    
    func reloadTasks() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.setNeedsUpdateContentUnavailableConfiguration()  //update changes
        }
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        var config = UIContentUnavailableConfiguration.empty()
        if viewModel.updatePageView() {
            config.image = UIImage(systemName: "square.and.pencil.circle.fill")
            config.text = "No Tasks"
            config.secondaryText = "If you want, you can add your tasks"
        }
        contentUnavailableConfiguration = config
        
    }

    
    func addTaskAlert(){
        let alert = UIAlertController(title: "Add a new task", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter your task"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            if let title = alert.textFields?.first?.text, !title.isEmpty {
                self?.viewModel.addTasks(with: title)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
