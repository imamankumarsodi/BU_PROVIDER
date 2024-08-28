//
//  SettingsTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/03/21.
//

import UIKit

class SettingsTableViewCell: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgSetting: UIImageView!
    @IBOutlet weak var lblSetting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: CategoryViewModel) {
        self.imgSetting.image = info.image
        self.lblSetting.text = info.title
    }
    
}
