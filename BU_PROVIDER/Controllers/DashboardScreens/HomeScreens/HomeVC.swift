//
//  HomeVC.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import UIKit
import ViewAnimator
class HomeVC: BaseViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var draggableView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var lblUnderReview: UILabel!
    @IBOutlet weak var lblAccountActive: UILabel!

    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var validationMethodManager:ValidationProtocol?
    internal var homeVM: CategoryListModeling?
    internal var categoryListVM:CategoryListViewModel?
    internal let zoomAnimation = AnimationType.zoom(scale: 0.2)
    internal let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    
    internal var lati:String = String()
    internal var longi:String = String()
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
        
        
    }
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //TODO: Implementation viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navSetup()
        self.animateView()
    }
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    
    @IBAction func btnEditTapped(_ sender: UIButton) {
      
        let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: EditProfileVC.className) as! EditProfileVC
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
  
    
    @objc func handler(gesture: UIPanGestureRecognizer){
            let location = gesture.location(in: self.view)
            let draggedView = gesture.view
            draggedView?.center = location
            
            if gesture.state == .ended {
                if self.draggableView.frame.midX >= self.view.layer.frame.width / 2 {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                        self.draggableView.center.x = self.view.layer.frame.width - 40
                    }, completion: nil)
                }else{
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                        self.draggableView.center.x = 40
                    }, completion: nil)
                }
            }
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
