//
//  sounTableViewCell.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/9/10.
//

import UIKit

class sounTableViewCell: UITableViewCell {

    @IBOutlet weak var lbsoundsee: UILabel!
    
    static let identifier = "sounTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
