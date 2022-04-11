//
//  EmptyHistoryTableViewCell.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 07/04/22.
//

import UIKit

protocol EmptyHistoryTableViewCellDelegate: AnyObject {
    func didTapButton()
}
class EmptyHistoryTableViewCell: UITableViewCell {
    
    weak var delegate: EmptyHistoryTableViewCellDelegate?
    
    static let identifier = "EmptyHistoryTableViewCell"
   
    @IBOutlet var button: UIButton!
    
    @IBAction private func didTapButton(){
        delegate?.didTapButton()
    }
    
    private var title: String = ""
    
    static func nib() -> UINib {
        return UINib(nibName: "EmptyHistoryTableViewCell", bundle: nil)
    }
    
    func configure() {
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
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
