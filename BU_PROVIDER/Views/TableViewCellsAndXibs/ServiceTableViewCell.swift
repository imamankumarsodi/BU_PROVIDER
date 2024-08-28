//
//  ServiceTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import UIKit

class ServiceTableViewCell: SBaseTableViewCell {
    
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBOutlet weak var btnEditRef: UIButton!
    @IBOutlet weak var btnViewSubServiceRef: UIButton!

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
    
    public func configure(with info: ServiceDataViewModel) {
        self.lblServiceName.text = info.service_name
        self.lblPrice.text = "\(ConstantTexts.CurLT) \(info.price)"
        self.lblStatus.text = info.status
    }

    
    
    
}
