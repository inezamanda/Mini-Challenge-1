//
//  EmptyHistoryTableViewCell.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

class EmptyHistoryTableViewCell: UITableViewCell {

    @IBAction func startProgressButton(_ sender: Any) {
    }
    
    static let identifier = "EmptyHistoryTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "EmptyHistoryTableViewCell", bundle: nil)
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
