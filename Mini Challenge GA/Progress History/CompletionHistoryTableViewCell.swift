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
    
    static let identifier = "CompletionHistoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "CompletionHistoryTableViewCell", bundle: nil)
    }
    
    public func configure(date: String, inProgress: Int, done: Int) {
        progressDate.text = date
        inProgressTask.text = String(inProgress)
        doneTask.text = String(done)
        card.layer.cornerRadius = 29
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
