//
//  AddAddreessVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import UIKit
import DropDown

class AddAddreessVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var manageTable: UITableView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var addressDataModel: DataStoreStructListModeling?
    internal var stateCityDataModelVM: StateCityDepnendencyInjection?
    internal var addressDataListVM:DataStoreStruct_List_ViewModel?
    
    internal var addressStateListVM:StateCityListViewModel?
    internal var states:[String] = [String]()
    internal var state_id:String = String()
    
    internal var addressCityListVM:StateCityListViewModel?
    internal var cities:[String] = [String]()
    internal var city_id:String = String()
    
    internal var callBackAddress:(()->())?
    internal var isComingForEditing:Bool = Bool()

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
    
    
    internal let dropDown = DropDown()
    
    
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
    
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    
    @objc func btnDDTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        let indexPath:IndexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = self.manageTable.cellForRow(at: indexPath) as? IDProofTableViewCell{
            
            if sender.tag == 0{
                self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: [ConstantTexts.Address_TypeLT,ConstantTexts.HomeLT,ConstantTexts.OfficeLT], anchor: cell.btnDDRef, callBack: { (dropDown) in
                    
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        if item == ConstantTexts.Address_TypeLT{
                            cell.textFieldFloating.text = ConstantTexts.empty
                            self.addressDataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                        }else{
                            cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.addressDataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
                    }
                })
            }else if sender.tag == 3{
                
                //http://krewtechnologies.com/buapp/public/api/user/state
                //http://krewtechnologies.com/buapp/public/api/provider/user/state
                
                self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: self.states, anchor: cell.btnDDRef, callBack: { (dropDown) in
                    
                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        
                        if item == ConstantTexts.State_PH{
                            cell.textFieldFloating.text = ConstantTexts.empty
                            self.addressDataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                            self.state_id = ConstantTexts.empty
                            
                        }else{
                            cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.addressDataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.state_id = self.addressStateListVM?.itemAtIndex(index).id ?? ConstantTexts.empty
                            self.hitgetCities(id: self.addressStateListVM?.itemAtIndex(index).id ?? ConstantTexts.empty)
                        }
                    }
                })
                
            }else if sender.tag == 4{
                
                if self.addressDataListVM?.dataStoreStructs[sender.tag - 1].value.trimmingCharacters(in: .whitespacesAndNewlines) != ConstantTexts.empty{
                    
                    
                    
                    self.customMethodManager?.openDownOnViewBottomDirection(dropDown: self.dropDown, array: self.cities, anchor: cell.btnDDRef, callBack: { (dropDown) in
                        
                        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                            print("Selected item: \(item) at index: \(index)")
                            
                            if item == ConstantTexts.City_PH{
                                cell.textFieldFloating.text = ConstantTexts.empty
                                self.addressDataListVM?.dataStoreStructs[sender.tag].value = ConstantTexts.empty
                                self.city_id = ConstantTexts.empty
                            }else{
                                cell.textFieldFloating.text = item.trimmingCharacters(in: .whitespacesAndNewlines)
                                self.addressDataListVM?.dataStoreStructs[sender.tag].value = item.trimmingCharacters(in: .whitespacesAndNewlines)
                                
                                self.city_id = self.addressCityListVM?.itemAtIndex(index).id ?? ConstantTexts.empty
                                
                            }
                        }
                    })
                }else{
                    
                    let indexPath = IndexPath(row: sender.tag - 1, section: 0)
                    if let cell = self.manageTable.cellForRow(at: indexPath) as? IDProofTableViewCell{
                        self.customMethodManager?.showToolTip(msg: ConstantTexts.SelectStateFirstALERT, anchorView: cell.textFieldFloating, sourceView: self.view)
                    }

                    
                   
                }

            }
            
            
           
        }
    }
    
    
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
    

}
