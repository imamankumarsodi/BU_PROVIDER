//
//  PersonalDetailsVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import UIKit
import DropDown


class PersonalDetailsVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblPersonalInfo: UITableView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var otpModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    internal var callBackPersonal:(()->())?
    internal let dropDown = DropDown()
    
    internal var pickerToolbar: UIToolbar?
    internal var datePicker = UIDatePicker()
    internal var isComingForEditing:Bool = Bool()
    
    let footer: SignupFooterView  = Bundle.main.loadNibNamed(SignupFooterView.className, owner: self, options: nil)?.last as! SignupFooterView
    
    
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
        if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
            
            if sender.tag == 1{
                self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: [ConstantTexts.SelectGender_LT,ConstantTexts.Male_LT,ConstantTexts.Female_LT], anchor: cell.btnDDRef, callBack: { (dropDown) in
                    
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        if item == ConstantTexts.SelectGender_LT{
                            cell.textFieldFloating.text = ConstantTexts.empty
                            self.dataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                        }else{
                            cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.dataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    }
                })
            }else{
                cell.textFieldFloating.becomeFirstResponder()
                
            }
            
            
           
        }
    }
    
    
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        let indexPath:IndexPath = IndexPath(row: 2, section: 0)
        if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
            cell.textFieldFloating?.resignFirstResponder()
        }
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        // dateTextField?.resignFirstResponder()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let indexPath:IndexPath = IndexPath(row: 2, section: 0)
        if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
            cell.textFieldFloating?.resignFirstResponder()
            self.dataListVM?.dataStoreStructs[2].value = formatter.string(from: datePicker.date)
            cell.textFieldFloating?.text = formatter.string(from: datePicker.date)
        }
      
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
