//
//  CompletionHistoryTableViewCell.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class CompletionHistoryTableViewCell: UITableViewCell {
    
    @IBOutlet var progressDate: UILabel!
    @IBOutlet var inProgressTask: UILabel!
    @IBOutlet var doneTask: UILabel!
    @IBOutlet var card: UIView!
    @IBOutlet var progressBar: ProgressBar!
    
    static let identifier = "CompletionHistoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CompletionHistoryTableViewCell", bundle: nil)
    }
    
    public func configure(date: String, inProgress: Int, done: Int, percentage: Double) {
        progressDate.text = date
        inProgressTask.text = String(inProgress)
        doneTask.text = String(done)
        card.layer.cornerRadius = 29
        
        var progressVal = Double(percentage)
        print(progressVal)
        progressBar.progress = CGFloat(progressVal/100)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
