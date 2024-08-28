//
//  IDProofVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import UIKit
import DropDown

class IDProofVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblIDProof: UITableView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var otpModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    
    internal let dropDown = DropDown()
    internal var docDataModeling:DocumentDataModeling?
    internal var docDataList:DocumentViewModelList?
    internal var callBackID:(()->())?
    let footer: IDProofFooter  = Bundle.main.loadNibNamed(IDProofFooter.className, owner: self, options: nil)?.last as! IDProofFooter
    
    internal var isComingForEditing:Bool = Bool()
    internal var type_id:String = String()
    
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
    
    @objc func btnDDTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        let indexPath:IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = self.tblIDProof.cellForRow(at: indexPath) as? IDProofTableViewCell{
            self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: [ConstantTexts.SelectID_LT,ConstantTexts.Driving_licence_LT,ConstantTexts.Passport_LT], anchor: cell.btnDDRef, callBack: { (dropDown) in
                
                dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    
                    if item == ConstantTexts.SelectID_LT{
                        cell.textFieldFloating.text = ConstantTexts.empty
                        self.dataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                    }else{
                        cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                        self.dataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
            })
        }
    }
    
    
    
    
    @objc func btnChooseTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        self.openActionSheet() 
    }
    
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
    
   
   
}
