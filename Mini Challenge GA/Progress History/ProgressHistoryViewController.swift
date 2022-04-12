//
//  ProgressHistoryViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class ProgressHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var lastWeekProgress = [
        DailyProgress(date: "Fri, 8 Apr 2022", inProgress: 2, done: 15, percentage: 70.0),
        DailyProgress(date: "Tue, 5 Apr 2022", inProgress: 2, done: 11, percentage: 65.0)
    ]
    
    var earlierProgress = [
        DailyProgress(date: "Fri, 25 Mar 2022", inProgress: 2, done: 8, percentage: 60.0),
        DailyProgress(date: "Thu, 24 Mar 2022", inProgress: 2, done: 6, percentage: 45.0),
        DailyProgress(date: "Tue, 15 Mar 2022", inProgress: 1, done: 3, percentage: 30.0),
        DailyProgress(date: "Mon, 14 Mar 2022", inProgress: 2, done: 1, percentage: 10.0)
        
    ]

    lazy var data: [TimeSection] = {
        let section1 = TimeSection(
            name: "This Week", data: []
        )
        
        let section2 = TimeSection(
            name: "Last Week",
            data: lastWeekProgress
        )
        
        let section3 = TimeSection(
            name: "Earlier",
            data: earlierProgress
        )
        
        return [section1, section2, section3]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Table
        tableView.register(CompletionHistoryTableViewCell.nib(), forCellReuseIdentifier: CompletionHistoryTableViewCell.identifier)
        tableView.register(EmptyHistoryTableViewCell.nib(), forCellReuseIdentifier: EmptyHistoryTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
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
        if data[section].numberOfItems == 0 {
            return 1
        }
        return data[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (data[indexPath.section].name == "This Week") {
            return 112
        }
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print(data[indexPath.section].data.count)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        // Empty Row State
        if data[indexPath.section].data.isEmpty {
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyHistoryTableViewCell.identifier, for: indexPath) as! EmptyHistoryTableViewCell
            cell.selectedBackgroundView = backgroundView
            cell.configure()
            cell.delegate = self
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CompletionHistoryTableViewCell.identifier, for: indexPath) as! CompletionHistoryTableViewCell
        cell.selectedBackgroundView = backgroundView
        
        let cellDetail = data[indexPath.section].data[indexPath.row]
        print(cellDetail)
        cell.configure(date: cellDetail.date, inProgress: cellDetail.inProgress, done: cellDetail.done, percentage: cellDetail.percentage)
        return cell
    }
    
}

extension ProgressHistoryViewController: EmptyHistoryTableViewCellDelegate {
    func didTapButton() {
        self.performSegue(withIdentifier: "progToTimerSeg", sender: self)
    }
}


