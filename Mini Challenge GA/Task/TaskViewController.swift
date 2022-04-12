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
    Task(name: "Bab 1", status: "done", category: "Book"),
    Task(name: "Bab 2", status: "done", category: "Book"),
    Task(name: "Bab 3", status: "done", category: "Book"),
    Task(name: "Bab 4", status: "in progress", category: "Book"),
    Task(name: "Bab 5", status: "not started", category: "Book"),
    Task(name: "Bab 6", status: "not started", category: "Book"),
    Task(name: "Developing Website", status: "done", category: "Implementation"),
    Task(name: "Built frontend page", status: "done", category: "Implementation"),
    Task(name: "Connecting to backend", status: "in progress", category: "Implementation"),
    Task(name: "Create Restful API", status: "done", category: "Implementation"),
    Task(name: "Designing hardware", status: "not started", category: "Implementation"),
    Task(name: "Desk research", status: "done", category: "Implementation"),
    Task(name: "Form survey", status: "done", category: "Implementation"),
]

class TaskViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    lazy var rowToDisplay = listTask
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rowToDisplay = listTask.filter { $0.category == "Book"}
        case 1:
            rowToDisplay = listTask.filter { $0.category == "Implementation"}
        default:
            break
        }
        
        tableView.reloadData()
    }
    
    @IBAction func addTaskAction(_ sender: Any) {
        didTapAddBtn()
    }
    
    @objc private func didTapAddBtn(){
        let vc = AddTaskViewController()
        vc.viewDelegate = self
        performSegue(withIdentifier: "addTaskSeg", sender: self)
    }
    
    @objc private func didTapEditBtn(){
        let vc = EditTaskViewController()
    
        if let indexPath = tableView.indexPathForSelectedRow {
            print(rowToDisplay[indexPath.row].name)
            vc.taskName = rowToDisplay[indexPath.row].name
            print(vc.taskName)
            vc.taskCategory = rowToDisplay[indexPath.row].category
        }
        performSegue(withIdentifier: "editTaskSeg", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if selectedCategory == 1 {
            segmentedControl.selectedSegmentIndex = 0
            rowToDisplay = listTask.filter { $0.category == "Book"}
        } else {
            segmentedControl.selectedSegmentIndex = 1
            rowToDisplay = listTask.filter { $0.category == "Implementation"}
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
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
        //print(rowToDisplay[indexPath.row])

        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        
        cell.taskLabel.text = rowToDisplay[indexPath.row].name
        let taskStatus = rowToDisplay[indexPath.row].status
        
        let statusIcon: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        
        if taskStatus == "done" {
            statusIcon.image = UIImage(systemName: "checkmark.circle")?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        } else if taskStatus == "in progress" {
            statusIcon.image = UIImage(systemName: "circle.dashed")?.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)
        } else {
            statusIcon.image = UIImage(systemName: "circle")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        }
        
        statusIcon.contentMode = .scaleAspectFit
        cell.accessoryView = statusIcon
        
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
            print(self.rowToDisplay[indexPath.row])
            let ind = listTask.firstIndex(where: { $0.name == self.rowToDisplay[indexPath.row].name})
            listTask.remove(at: ind!)
            self.rowToDisplay.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
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

extension TaskViewController: AddTaskControllerDelegate {
    func onSave() {
        print("masokk")
        tableView.reloadData()
        
    }
}
