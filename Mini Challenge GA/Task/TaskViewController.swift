//
//  TaskViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

struct Task {
    var name: String
    var status: String
    var category: String
}

var listTask: [Task] = [
    Task(name: "Identify problems", status: "done", category: "Book Progress"),
    Task(name: "Identify problems 2", status: "not started", category: "Book Progress"),
    Task(name: "Identify problems 3", status: "in progress", category: "Book Progress"),
    Task(name: "Identify problems 4", status: "not started", category: "Implementation"),
    Task(name: "Identify problems 5", status: "not started", category: "Implementation"),
    Task(name: "Identify problems 6", status: "in progress", category: "Implementation"),
]

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    
    lazy var rowToDisplay = listTask
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rowToDisplay = listTask.filter { $0.category == "Book Progress"}
        case 1:
            rowToDisplay = listTask.filter { $0.category == "Implementation"}
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addTaskAction(_ sender: Any) {
        performSegue(withIdentifier: "addTaskSeg", sender: self)
    }
    
    @objc private func didTapEditBtn(){
        performSegue(withIdentifier: "editTaskSeg", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if selectedCategory == 1 {
            segmentedControl.selectedSegmentIndex = 0
            rowToDisplay = listTask.filter { $0.category == "Book Progress"}
        } else {
            segmentedControl.selectedSegmentIndex = 1
            rowToDisplay = listTask.filter { $0.category == "Implementation"}
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        header.backgroundColor = .clear

        let label = UILabel(frame: CGRect(x: 16, y: 6,
                                          width: header.frame.size.width - 15,
                                          height: header.frame.size.height - 10))
        
        label.text = rowToDisplay[section].category
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(rowToDisplay)

        let cell = tableView.dequeueReusableCell(withIdentifier: "taskTableViewCell", for: indexPath) as! TaskTableViewCell
        
        cell.taskLabel.text = rowToDisplay[indexPath.row].name
        let taskStatus = rowToDisplay[indexPath.row].status
        
        if taskStatus == "done" {
            let doneIcon = UIImage(systemName: "checkmark")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
            let doneIconView = UIImageView(image: doneIcon)
            doneIconView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
            cell.accessoryView = doneIconView
        } else if taskStatus == "in progress" {
            let progressIcon = UIImage(systemName: "arrow.triangle.2.circlepath")?.withTintColor(.blue, renderingMode: .alwaysOriginal)
            let progressIconView = UIImageView(image: progressIcon)
            progressIconView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
            cell.accessoryView = progressIconView
        } else {
            cell.accessoryView = nil
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    private func edit(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .normal, title: "Edit") { [weak self] (_, _, _) in
            guard let self = self else {return}
            self.didTapEditBtn()
        }
        action.image = UIImage(systemName: "pencil")?.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
        return action
    }
    
    private func delete(rowIndexPathAt indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Delete") {[weak self] (_, _, _) in
            guard let self = self else {return}
            self.rowToDisplay.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            listTask.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
        action.image = UIImage(systemName: "trash.fill")?.withTintColor(.systemBackground, renderingMode: .alwaysOriginal)
        return action
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = self.edit(rowIndexPathAt: indexPath)
        let delete = self.delete(rowIndexPathAt: indexPath)
        let swipeAction = UISwipeActionsConfiguration(actions: [delete, edit])
        
        return swipeAction
    }

}

