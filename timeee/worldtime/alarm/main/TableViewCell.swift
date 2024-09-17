//
//  TableViewCell.swift
//  timeee
//
//  Created by imac 1682's MacBook Pro on 2024/8/16.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbtime: UILabel!
    @IBOutlet weak var lbnoon: UILabel!
    
    @IBOutlet weak var swturn: UISwitch!
    @IBOutlet weak var lbunder: UILabel!
    
    static let identifier = "TableViewCell"
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
