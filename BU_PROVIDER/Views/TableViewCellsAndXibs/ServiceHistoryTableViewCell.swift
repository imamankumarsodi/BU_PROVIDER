//
//  ServiceHistoryTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import UIKit

class ServiceHistoryTableViewCell: SBaseTableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblServiceName: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    
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
    
    public func configure(with info: ServiceHistoryViewDataModel) {
        self.lblServiceName.text = info.service_name
        self.lblPrice.text = "\(ConstantTexts.CurLT) \(info.amount)"
        self.lblUserName.text = info.first_name
        self.lblDateTime.text = info.service_date
    }
    
}
