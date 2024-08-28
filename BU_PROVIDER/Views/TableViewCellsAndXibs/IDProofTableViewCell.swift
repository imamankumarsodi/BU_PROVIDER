//
//  IDProofTableViewCell.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import UIKit
import SkyFloatingLabelTextField


class IDProofTableViewCell: SBaseTableViewCell {
    internal var showPasswordCallBack:(()->())?
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldFloating: SkyFloatingLabelTextField!
    @IBOutlet weak var btnEyeRef: UIButton!
    @IBOutlet weak var btnDDRef: UIButton!
    
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
        self.textFieldFloating.text = info.value
        
        switch info.type{
        case .IDProof:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            
            
            
        case .Gender:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            
            
        case .DOB:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            
            
            
        case .NameID:
            
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .namePhonePad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            
            
        case .SOWO:
            
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .namePhonePad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .words
            
            
        case .IDNumber:
            
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .allCharacters
            
            
        case .SelectAddressType:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .Address:
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 200
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .Area:
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 200
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
        case .State:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
        case .City:
            btnDDRef.isHidden = false
            btnEyeRef.isHidden = false
            
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
       
        
        case .ZipCode:
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 5
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .ACNumber:
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 20
            textFieldFloating.keyboardType = .numberPad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
            
        case .IFSC:
            btnDDRef.isHidden = true
            btnEyeRef.isHidden = true
            
            textFieldFloating.maxLength = 15
            textFieldFloating.keyboardType = .namePhonePad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .allCharacters
            
        default :
            return
        }
        
        
        
        
    }
    
    
}
