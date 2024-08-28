//
//  OnboardingTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import UIKit

class OnboardingTableViewCell:SBaseTableViewCell  {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewStatusContainer: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgViewCheck: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
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
    
    public func configure(with info: OnboardingViewModel) {
        if info.status{
            self.viewStatusContainer.backgroundColor = AppColor.app_pass_color
            self.lblNumber.isHidden = true
            self.imgViewCheck.isHidden = false
        }else{
            self.viewStatusContainer.backgroundColor = AppColor.app_theame_color
            self.lblNumber.isHidden = false
            self.imgViewCheck.isHidden = true
        }
        
        self.lblNumber.text = info.serialNumber
        self.lblTitle.text = info.title
      
    }
    
    
}
