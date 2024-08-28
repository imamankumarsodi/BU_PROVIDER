//
//  BankDetailsVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import UIKit

class BankDetailsVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblIDProof: UITableView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var otpModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    
    internal var docDataModeling:DocumentDataModeling?
    internal var docDataList:DocumentViewModelList?
    
    internal var callBackBank:(()->())?
    
    let footer: IDProofFooter  = Bundle.main.loadNibNamed(IDProofFooter.className, owner: self, options: nil)?.last as! IDProofFooter
    
    
    //MARK: - User Data
    internal var userDataVM:DataStoreStruct_List_ViewModel?
    
    //MARK: - variables for the animate tableview
    internal var animationName = String()
    
    /// an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
    internal var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03) {
        didSet {
            self.animationName = currentTableAnimation.getTitle()
        }
    }
    internal var animationDuration: TimeInterval = 0.85
    internal var delay: TimeInterval = 0.05
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initValues()
        
    }
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navSetup()
    }
    
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    @objc func btnSaveTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.footer.btnContinueRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.footer.btnContinueRef.transform = CGAffineTransform.identity
                            self.isValidate()
                        }
                       })
    }
    
    @objc func btnChooseTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        self.openActionSheet()
    }
   
   
}
