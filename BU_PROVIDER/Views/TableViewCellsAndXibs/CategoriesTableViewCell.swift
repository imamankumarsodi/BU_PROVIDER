//
//  CategoriesTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import UIKit

class CategoriesTableViewCell: SBaseTableViewCell {

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
        self.imgSetting.backgroundColor =  info.isSelected ? AppColor.app_theame_color : AppColor.whiteColor
        self.lblSetting.text = info.title
    }
    
    
}
