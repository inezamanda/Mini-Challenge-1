//
//  ChooseProgressViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 12/04/22.
//

import UIKit

class ChooseProgressViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var isProgressing: Bool = false
    
    lazy var rowToDisplay = listTask.filter { $0.category == "Book"}
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if !isProgressing {
            saveButton.isEnabled = false
        }
        
        self.isModalInPresentation = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35 + 44))
        header.backgroundColor = .clear

        let label = UILabel(frame: CGRect(x: UIEdgeInsets().left + 16, y: UIEdgeInsets().bottom,
                                          width: header.frame.size.width - 15,
                                          height: header.frame.size.height - 10 - 44))
        
        label.text = rowToDisplay[section].category
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        let searchBar = UISearchBar()
//        print(header.frame.width)
        searchBar.frame = CGRect(x: UIEdgeInsets().left , y: label.frame.height, width: header.frame.size.width - 40, height: 44)
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = "Search"
        //searchBar.backgroundColor = UIColor.systemGreen
        //searchBar.size
        searchBar.sizeToFit()
        
        header.addSubview(label)
        header.addSubview(searchBar)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35 + 44
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(rowToDisplay[indexPath.row])

        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseProgressTableViewCell.identifier, for: indexPath) as! ChooseProgressTableViewCell
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = rowToDisplay[indexPath.row].name
        
        let sheet = UIAlertController(title: "\(item)", message: nil, preferredStyle: .actionSheet)
        sheet.addAction(UIAlertAction(title: "Done", style: .default, handler: { _ in
            
            if self.rowToDisplay[indexPath.row].status != "done" {
                self.saveButton.isEnabled = true
            }
            
            listTask[indexPath.row].status = "done"
            self.rowToDisplay[indexPath.row].status = "done"

            self.tableView.reloadData()

            print("\(item) done")
            print(self.rowToDisplay[indexPath.row])
            print(listTask[indexPath.row])
        }))
        
        sheet.addAction(UIAlertAction(title: "In Progress", style: .default, handler: { _ in
            
            if self.rowToDisplay[indexPath.row].status != "in progress" {
                self.saveButton.isEnabled = true
            }
            
            listTask[indexPath.row].status = "in progress"
            self.rowToDisplay[indexPath.row].status = "in progress"
            
            self.tableView.reloadData()
            
            print("\(item) in progress")
            print(self.rowToDisplay[indexPath.row])
            print(listTask[indexPath.row])
        }))
        
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(sheet, animated: true)
    }
    
    
    
}
