//
//  ProgressHistoryViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class TimeSection {
    var name: String
    var data: [DailyProgress]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> DailyProgress {
        return data[index]
    }
    
    init(name: String, data: [DailyProgress]){
        self.name = name
        self.data = data
    }
}

struct DailyProgress {
    var date: String
    var inProgress: Int
    var done: Int
    var percentage: Int

    init(date: String, inProgress: Int, done: Int, percentage: Int){
        self.date = date
        self.inProgress = inProgress
        self.done = done
        self.percentage = percentage
    }
    
}

class ProgressHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var dailyProgress = [
        DailyProgress(date: "Thu, 24 Mar 2022", inProgress: 2, done: 5, percentage: 50),
        DailyProgress(date: "Thu, 24 Mar 2022", inProgress: 2, done: 5, percentage: 50)
    ]

    lazy var data: [TimeSection] = {
        let section1 = TimeSection(
            name: "This Week", data: []
        )
        
        let section2 = TimeSection(
            name: "Last Week",
            data: dailyProgress
        )
        
        let section3 = TimeSection(
            name: "Earlier",
            data: dailyProgress
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

        let label = UILabel(frame: CGRect(x: 0, y: 0,
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
            let cell = tableView.dequeueReusableCell(withIdentifier: EmptyHistoryTableViewCell.identifier, for: indexPath)
            cell.selectedBackgroundView = backgroundView
            print("masuk")
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CompletionHistoryTableViewCell.identifier, for: indexPath) as! CompletionHistoryTableViewCell
        cell.selectedBackgroundView = backgroundView
        
        let cellDetail = data[indexPath.section].data[indexPath.row]
        print(cellDetail)
        cell.configure(date: cellDetail.date, inProgress: cellDetail.inProgress, done: cellDetail.done)
        return cell
    }
    
}


