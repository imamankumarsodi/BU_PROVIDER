//
//  OTP_VC.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit

class OTP_VC:BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var otpTable: UITableView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var otpModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    
    let header: AuthHeader  = Bundle.main.loadNibNamed(AuthHeader.className, owner: self, options: nil)?.first as! AuthHeader
    
    let footer: SignupFooterView  = Bundle.main.loadNibNamed(SignupFooterView.className, owner: self, options: nil)?.last as! SignupFooterView
    
    
    //MARK: - User Data
    internal var userDataVM:DataStoreStruct_List_ViewModel?
    internal var authVerificationID:String = String()
    internal var isComingFromSignIn:Bool = Bool()
    
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
    
    @objc func btnbtnContinueTapped(_ sender: UIButton) {
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
    
    
    
    //TODO: Selectors
    //Calls this function when the tap is recognized.
    @objc func lblSignInRefTapped(_ sender: UITapGestureRecognizer) {
        self.resendFireBaseOTP()
        
    }
    
   
}
