//
//  ViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 05/04/22.
//

import UIKit

var selectedCategory = 1

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //@IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var data: [SectionData] = {
        let section1 = SectionData(
            name: "My Progress",
            data: [
                Report(time: "9h 20m", durationTarget: "10h 0m", words: "Well done! You have reached your weekly duration target!", emoji: "images")
            ]
        )
        
        let section2 = SectionData(
            name: "Final Project Completion",
            data: [
                FinalProjectCompletion(category: "Book", notStarted: 3, inProgress: 2, done: 5, percentage: 50.0, emoji: "books.vertical.fill"),
                FinalProjectCompletion(category: "Implementation", notStarted: 3, inProgress: 2, done: 5, percentage: 50.0, emoji: "hammer.fill")
            ]
        )
        
        return [section1, section2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Profile Image
        //circularImage.layer.cornerRadius = circularImage.frame.size.height/2
        //circularImage.clipsToBounds = true
        
        // Table
        tableView.register(ReportTableViewCell.nib(), forCellReuseIdentifier: ReportTableViewCell.identifier)
        tableView.register(ProjectCompletionTableViewCell.nib(), forCellReuseIdentifier: ProjectCompletionTableViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        //header.inset = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
        //header.backgroundColor = .red

        let label = UILabel(frame: CGRect(x: 16, y: 0,
                                          width: header.frame.size.width - 15,
                                          height: header.frame.size.height - 10))

        
        label.text = data[section].name
        label.font = .systemFont(ofSize: 22, weight: .bold)
        
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 196
        }
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let elem = data[indexPath.section].data[indexPath.row]
        //print(cellDetail)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        if indexPath.section  < 1 {
            if let thisCell = elem as? Report {
                let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier, for: indexPath) as! ReportTableViewCell
                cell.configure(timeProgress: thisCell.time, duration: thisCell.durationTarget, encourage: thisCell.words, imageName: thisCell.emoji)
                cell.selectedBackgroundView = backgroundView
                return cell
            }
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCompletionTableViewCell.identifier, for: indexPath) as! ProjectCompletionTableViewCell
        if let thisCell = elem as? FinalProjectCompletion {
            cell.configure(categorySymbolName: thisCell.emoji, category: thisCell.category, notStarted: thisCell.notStarted, inProgress: thisCell.inProgress, done: thisCell.done, percentage: thisCell.percentage)
            cell.selectedBackgroundView = backgroundView
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let elem = data[indexPath.section].data[indexPath.row]
        
        if (data[indexPath.section].name == "My Progress") {
            performSegue(withIdentifier: "summarySeg", sender: self)
        }
        else {
            if let thisCell = elem as? FinalProjectCompletion {
                
                if thisCell.category == "Book" {
                    selectedCategory = 1
                } else if thisCell.category == "Implementation" {
                    selectedCategory = 2
                }
                
                // direct to task list screen
                performSegue(withIdentifier: "taskSeg", sender: self)
            }
        }
    }
}

