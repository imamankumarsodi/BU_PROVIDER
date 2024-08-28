//
//  ServiceDetailVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import UIKit
import DropDown

class ServiceDetailVC: BaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblPersonalInfo: UITableView!
    
    //MARK: - Variables
    
    
    internal var customMethodManager:CustomMethodProtocol?
    internal var otpModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    
    internal var isComingFromEdit:Bool = Bool()
    internal let dropDown = DropDown()
    internal let sNameArray = [ConstantTexts.SelectService_PH,ConstantTexts.SPA_LT,ConstantTexts.HairDressingLT,ConstantTexts.MakeUpLT,ConstantTexts.BarberShopLT,ConstantTexts.BrushLT,ConstantTexts.BeautyNailsLT]
    
    internal let sIdArray = ["","11","12","13","14","15","16"]
    internal var selectedId:String = String()
    internal var selectedTag:String = String()
    internal var info:ServiceDataViewModel?
    internal var id:String = String()
    
    
    let footer: AddServiceFooter  = Bundle.main.loadNibNamed(AddServiceFooter.className, owner: self, options: nil)?.last as! AddServiceFooter
    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @objc func btnDDTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        let indexPath:IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = self.tblPersonalInfo.cellForRow(at: indexPath) as? IDProofTableViewCell{
            if sender.tag == 0{
                self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: self.sNameArray, anchor: cell.btnDDRef, callBack: { (dropDown) in
                    
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        if item == ConstantTexts.SelectService_PH{
                            cell.textFieldFloating.text = ConstantTexts.empty
                            self.dataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                            self.selectedId = ConstantTexts.empty
                        }else{
                            cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.dataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.selectedId = self.sIdArray[index]
                        }
                    }
                })
            }
        }
    }
    
    
    @objc func btnSaveTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        self.isValidate()
        
        
    }
    
    @objc func btnSelectOnlineOflineTapped(_ sender: UIButton) {
        if sender.tag == 0{
            self.selectedTag = "online"
            self.footer.btnOnlineRef.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.footer.btnOflineRef.setImage(UIImage(systemName: "square"), for: .normal)
        }else{
            self.selectedTag = "offline"
            self.footer.btnOnlineRef.setImage(UIImage(systemName: "square"), for: .normal)
            self.footer.btnOflineRef.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    
    
}
