//
//  HomeCollectionViewCellAndXib.swift
//  BU
//
//  Created by Aman Kumar on 18/01/21.
//

import UIKit

class HomeCollectionViewCellAndXib: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var titlelLabelCategory: UILabel!
    @IBOutlet weak var viewBG: UIView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
       // self.titlelLabelCategory.transform = CGAffineTransform(rotationAngle: (270 * .pi) / 180)
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], .lightGray,  -1, 1, 1, 3, 0, AppColor.clearColor)
    }
    
    
    //TODO: Configure with info
    public func configure(with info: CategoryViewModel){
        self.titlelLabelCategory.text = info.title
        self.imageCategory.image = info.image
        //customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url)
    }

}
