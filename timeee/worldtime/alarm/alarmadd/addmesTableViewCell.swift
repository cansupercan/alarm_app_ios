//
//  addmesTableViewCell.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/19.
//

import UIKit

class addmesTableViewCell: UITableViewCell {
    static let identifier = "addmesTableViewCell"
    @IBOutlet weak var lbmes: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
