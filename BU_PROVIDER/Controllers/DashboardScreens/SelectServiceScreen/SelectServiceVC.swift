//
//  SelectServiceVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import UIKit

class SelectServiceVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblSettings: UITableView!
    @IBOutlet weak var search_bar: UISearchBar!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnCallBackRef: UIButton!
    
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var settingsVM: CategoryListModeling?
    internal var categoryListVM:CategoryListViewModel?
    
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
    
    
    //TODO: Actions
    @IBAction func btnAccepetTapped(_ sender: UIButton) {
           UIView.animate(withDuration: 0.1,
           animations: {
               
               self.btnCallBackRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
           },
           completion: { _ in
               UIView.animate(withDuration: 0.1) {
                  
                   self.btnCallBackRef.transform = CGAffineTransform.identity
                
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
