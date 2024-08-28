//
//  LoginVC.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn

class LoginVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var logInTable: UITableView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var logInModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    
    
    let header: AuthHeader  = Bundle.main.loadNibNamed(AuthHeader.className, owner: self, options: nil)?.first as! AuthHeader
    
    let footer: LoginFooter  = Bundle.main.loadNibNamed(LoginFooter.className, owner: self, options: nil)?.last as! LoginFooter
    
    
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
    
    @objc func btnFBTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.footer.viewFB.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.footer.viewFB.transform = CGAffineTransform.identity
                            self.FBLoginSetup()
                        }
                       })
        
    }
    
    @objc func btnGmailTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.footer.viewGmail.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.footer.viewGmail.transform = CGAffineTransform.identity
                           // self.isValidate()
                            if !NetworkState.isConnected() {
                                self.customMethodManager?.showAlert(ConstantTexts.noInterNet, okButtonTitle: ConstantTexts.OkBT, target: nil)
                                return
                            }
                            
                            
                            UtilityHelper.sharedInstance.showActivityIndicator(color: AppColor.header_color)

                            GIDSignIn.sharedInstance().signOut()
                            GIDSignIn.sharedInstance().delegate = self
                            GIDSignIn.sharedInstance().signIn()
                        }
                       })
        
    }
    
    
    @objc func btnAppleTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.footer.viewApple.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.footer.viewApple.transform = CGAffineTransform.identity
                            self.hitAppleLogin()
                           // self.isValidate()
                        }
                       })
        
    }
    
    
    
    //TODO: Selectors
    //Calls this function when the tap is recognized.
    @objc func lblSignUpRefTapped(_ sender: UITapGestureRecognizer) {
       let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: SignUpVC.className) as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
      /*  let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: BankDetailsVC.className) as! BankDetailsVC
         self.navigationController?.pushViewController(vc, animated: true) */
        
        
    }
    
}
