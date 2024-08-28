//
//  SplashVC.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit

class SplashVC: BaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var logo_splash: UIStackView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initialSetup()
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
