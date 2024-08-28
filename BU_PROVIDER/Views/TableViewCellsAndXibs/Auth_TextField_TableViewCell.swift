//
//  SBaseTableViewCell.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//


import UIKit
import SkyFloatingLabelTextField

class Auth_TextField_TableViewCell: SBaseTableViewCell {
    
    
    internal var showPasswordCallBack:(()->())?
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldFloating: SkyFloatingLabelTextField!
    
    @IBOutlet weak var btnEyeRef: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.textFieldFloating.titleFormatter = { $0 }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: DataStoreStruct_ViewModel) {
        self.textFieldFloating.placeholder = info.placeholder
        self.textFieldFloating.title = info.title
        
        switch info.type{
        case .PhoneNumber:
            textFieldFloating.maxLength = 10
            textFieldFloating.keyboardType = .numberPad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            btnEyeRef.isHidden = true
            
            
        case .FullName:
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .namePhonePad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            btnEyeRef.isHidden = true
            
            
        case .Email:
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .emailAddress
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            btnEyeRef.isHidden = true
            
            
        case .OTP:
            textFieldFloating.maxLength = 6
            textFieldFloating.keyboardType = .numberPad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            btnEyeRef.isHidden = true
            
        case .Comment:
            textFieldFloating.maxLength = 200
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            btnEyeRef.isHidden = true
            
        case .Password:
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = true
            textFieldFloating.autocapitalizationType = .words
            btnEyeRef.isHidden = false
            let image = textFieldFloating.isSecureTextEntry ? UIImage(systemName: "eye.slash.fill") : UIImage(systemName: "eye.fill")
            btnEyeRef.setImage(image, for: .normal)
            
        default :
            return
        }
        
        
        
        
    }
    
    
    @IBAction func btnShowPasswordTapped(_ sender: UIButton) {
        self.showPasswordCallBack?()
        
    }
    
}
