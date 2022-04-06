//
//  ViewController.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 05/04/22.
//

import UIKit

struct ProgressReport {
    var time: String?
    var targetDuration: String?
    var emoji: UIImage
}

struct CategoryCompletion {
    var name: String?
    var todo: Int?
    var ongoing: Int?
    var done: Int?
    var percentage: Int?
}

struct FinalProjectCompletion {
    var category: [CategoryCompletion]
}

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var circularImage: UIImageView!
    @IBOutlet weak var progressTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Profile Image
        circularImage.layer.cornerRadius = circularImage.frame.size.height/2
        circularImage.clipsToBounds = true
    }


}

