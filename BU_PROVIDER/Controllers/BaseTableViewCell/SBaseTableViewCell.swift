//
//  SBaseTableViewCell.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit

class SBaseTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
