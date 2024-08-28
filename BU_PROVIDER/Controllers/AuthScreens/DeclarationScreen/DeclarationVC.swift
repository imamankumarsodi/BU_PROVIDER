//
//  DeclarationVC.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import UIKit

class DeclarationVC: BaseViewController {

    
    //MARK: - IBOutlets
    @IBOutlet weak var btnCallBackRef: UIButton!
    @IBOutlet weak var txtView: UITextView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var callBackDec:(()->())?
    internal var isComingForEditing:Bool = Bool()
    
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
    
    
    //TODO: Actions
    @IBAction func btnAccepetTapped(_ sender: UIButton) {
           UIView.animate(withDuration: 0.1,
           animations: {
               
               self.btnCallBackRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
           },
           completion: { _ in
               UIView.animate(withDuration: 0.1) {
                  
                   self.btnCallBackRef.transform = CGAffineTransform.identity
                   self.hitDecleraionCheck()
               }
           })
    
       }

}
