//
//  ReportTableViewCell.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    @IBOutlet var reportCard: UIView!
    @IBOutlet var emojiImageView: UIImageView!
    @IBOutlet var time: UILabel!
    @IBOutlet var durationTarget: UILabel!
    @IBOutlet var words: UILabel!
    
    static let identifier = "ReportTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ReportTableViewCell", bundle: nil)
    }
    
    public func configure(timeProgress: String, duration: String, encourage: String, imageName: String) {
        emojiImageView.image = UIImage(named: imageName)
        time.text = timeProgress
        durationTarget.text = duration
        words.text = encourage
        reportCard.layer.cornerRadius = 29
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
