//
//  ProjectCompletionTableViewCell.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class ProjectCompletionTableViewCell: UITableViewCell {
    
    @IBOutlet var Card: UIView!
    @IBOutlet var categorySymbol: UIImageView!
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var notStartedTask: UILabel!
    @IBOutlet var inProgressTask: UILabel!
    @IBOutlet var doneTask: UILabel!
    @IBOutlet var progressBar: ProgressBar!
    
    static let identifier = "ProjectCompletionTableViewCell"
    
    
    static func nib() -> UINib {
        return UINib(nibName: "ProjectCompletionTableViewCell", bundle: nil)
    }
    
    public func configure(categorySymbolName: String, category: String, notStarted: Int, inProgress: Int, done: Int, percentage: Double) {
        categorySymbol.image = UIImage(systemName: categorySymbolName)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        categoryName.text = category
        notStartedTask.text = String(notStarted)
        inProgressTask.text = String(inProgress)
        doneTask.text = String(done)
        Card.layer.cornerRadius = 29
        
        var progressVal = Double(percentage)
        // print(progressVal)
        self.progressBar.progress = CGFloat(progressVal/100)
       
        //Card.layer.masksToBounds = true
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
