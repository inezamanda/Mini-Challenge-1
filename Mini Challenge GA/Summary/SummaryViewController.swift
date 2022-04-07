//
//  ViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 05/04/22.
//

import UIKit

class SectionData {
    var name: String
    var data: [Any]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> Any {
        return data[index]
    }
    
    init(name: String, data: [Any]){
        self.name = name
        self.data = data
    }
}

struct Report {
    var time: String
    var emoji: String
    var durationTarget: String
    var words: String
    
    init(time: String, emoji: String, durationTarget: String, words: String){
        self.time = time
        self.emoji = emoji
        self.durationTarget = durationTarget
        self.words = words
    }
}

struct FinalProjectCompletion {
    var category: String
    var notStarted: Int
    var inProgress: Int
    var done: Int
    var percentage: Int

    init(category: String, notStarted: Int, inProgress: Int, done: Int, percentage: Int){
        self.category = category
        self.notStarted = notStarted
        self.inProgress = inProgress
        self.done = done
        self.percentage = percentage
    }
}

class SummaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var data: [SectionData] = {
        let section1 = SectionData(
            name: "My Progress",
            data: [
                Report(time: "9h 20m", emoji: "images", durationTarget: "10h 0m", words: "Well done! You have reached your weekly duration target!")
            ]
        )
        
        let section2 = SectionData(
            name: "Final Project Completion",
            data: [
                FinalProjectCompletion(category: "Book Progress", notStarted: 3, inProgress: 2, done: 5, percentage: 50),
                FinalProjectCompletion(category: "Implementation", notStarted: 3, inProgress: 2, done: 5, percentage: 50)
            ]
        )
        
        return [section1, section2]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Profile Image
        circularImage.layer.cornerRadius = circularImage.frame.size.height/2
        circularImage.clipsToBounds = true
        
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
        return data[section].numberOfItems
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 196
        }
        return 110
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellDetail = data[indexPath.section].data[indexPath.row]
        //print(cellDetail)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        
        if indexPath.section  < 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReportTableViewCell.identifier, for: indexPath) as! ReportTableViewCell
            cell.configure(timeProgress: "9h 20m", duration: "10h 0m", encourage: "Well done! You have reached your weekly duration target!", imageName: "images")
            cell.selectedBackgroundView = backgroundView
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProjectCompletionTableViewCell.identifier, for: indexPath) as! ProjectCompletionTableViewCell
        cell.configure(categorySymbolName: "books.vertical.fill", category: "Book Progress", notStarted: 3, inProgress: 2, done: 5)
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "summarySeg", sender: self)
    }
}

