//
//  EarningsVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import UIKit

class EarningsVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var tblEarnings: UITableView!
    
    @IBOutlet weak var lblEarnings: UILabel!
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_theame_color
        
        return refreshControl
    }()
 
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var serviceModeling:ServiceHistoryModeling?
    internal var services:ServiceHistoryListModel?
    
    let header: ServiceHistoryHeader  = Bundle.main.loadNibNamed(ServiceHistoryHeader.className, owner: self, options: nil)?.first as! ServiceHistoryHeader
    
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
    
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        //self.hitgetServiceHistory()
        refreshControl.endRefreshing()
        
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
