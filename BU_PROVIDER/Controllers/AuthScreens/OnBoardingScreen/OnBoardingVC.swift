//
//  OnBoardingVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import UIKit

class OnBoardingVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var obTableView: UITableView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var onboardingVM: OnBoardingModeling?
    internal var dataListVM:OnboardingListViewModel?
    
    let header: OnboardingHeaderView  = Bundle.main.loadNibNamed(OnboardingHeaderView.className, owner: self, options: nil)?.first as! OnboardingHeaderView
    
    let footer: SignupFooterView  = Bundle.main.loadNibNamed(SignupFooterView.className, owner: self, options: nil)?.last as! SignupFooterView
    
    
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
                           // self.isValidate()
                            
                            guard let userData = self.customMethodManager?.getUser(entity: "User_Data") else{
                                print("No user found...")
                                return
                            }
                            
                            print(userData.status)
                            
                            switch userData.status{
                            case "onboarding" :
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: IDProofVC.className) as! IDProofVC
                                vc.callBackID = { [weak self] in
                                    self?.dataListVM?.onboardingDataList[0].status = true
                                    DispatchQueue.main.async {
                                        self?.obTableView.reloadData()
                                    }
                                }
                               self.navigationController?.pushViewController(vc, animated: true)
                                
                            case "idproof" :
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: PersonalDetailsVC.className) as! PersonalDetailsVC
                                
                                vc.callBackPersonal = { [weak self] in
                                    self?.dataListVM?.onboardingDataList[0].status = true
                                    self?.dataListVM?.onboardingDataList[1].status = true
                                    DispatchQueue.main.async {
                                        self?.obTableView.reloadData()
                                    }
                                }
                                
                                
                               self.navigationController?.pushViewController(vc, animated: true)
                                
                            case "personaldetails" :
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: AddAddreessVC.className) as! AddAddreessVC
                                
                                vc.callBackAddress = { [weak self] in
                                    self?.dataListVM?.onboardingDataList[0].status = true
                                    self?.dataListVM?.onboardingDataList[1].status = true
                                    self?.dataListVM?.onboardingDataList[2].status = true
                                    DispatchQueue.main.async {
                                        self?.obTableView.reloadData()
                                    }
                                }
                                
                               self.navigationController?.pushViewController(vc, animated: true)
                                
                                
                            case "address" :
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: DeclarationVC.className) as! DeclarationVC
                                
                                vc.callBackDec = { [weak self] in
                                    self?.dataListVM?.onboardingDataList[0].status = true
                                    self?.dataListVM?.onboardingDataList[1].status = true
                                    self?.dataListVM?.onboardingDataList[2].status = true
                                    self?.dataListVM?.onboardingDataList[3].status = true
                                    DispatchQueue.main.async {
                                        self?.obTableView.reloadData()
                                    }
                                }
                                
                                
                                
                               self.navigationController?.pushViewController(vc, animated: true)
                                
                                
                            case "declaration" :
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: BankDetailsVC.className) as! BankDetailsVC
                               self.navigationController?.pushViewController(vc, animated: true)
                                
                            case "pending","approved","underreview":
                                
                                let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                UIApplication.shared.windows.first?.rootViewController = vc
                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                                
                            default:
                                let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: IDProofVC.className) as! IDProofVC
                                    vc.callBackID = { [weak self] in
                                        self?.dataListVM?.onboardingDataList[0].status = true
                                        DispatchQueue.main.async {
                                            self?.obTableView.reloadData()
                                        }
                                    }
                                   self.navigationController?.pushViewController(vc, animated: true)
                               
                            }
                            
                        }
                       })
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
