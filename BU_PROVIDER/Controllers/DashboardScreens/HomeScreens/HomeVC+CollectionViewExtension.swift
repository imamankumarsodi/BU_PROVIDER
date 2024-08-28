//
//  HomeVC+CollectionViewExtension.swift
//  BU
//
//  Created by Aman Kumar on 18/01/21.
//

import Foundation
import UIKit
import ViewAnimator

//MARK: - UICollectionViewDataSource extension
extension HomeVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCellAndXib.className, for: indexPath) as? HomeCollectionViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        guard let info = categoryListVM?.categoryAtIndex(indexPath.row) else {
            fatalError(ConstantTexts.noDataIndexPath)
        }
        cell.configure(with:info)
        return cell
    }
    
    
    
}



//MARK: - UICollectionViewDelegate extension
extension HomeVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCellAndXib {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.whiteColor
                            
                            self.customMethodManager?.provideShadowAndCornerRadius(cell.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], .white,  0, 0, 0, 0, 0, AppColor.clearColor)
                            
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            if let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCellAndXib {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                
                                self.customMethodManager?.provideShadowAndCornerRadius(cell.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], .lightGray,  -1, 1, 1, 3, 0, AppColor.clearColor)
                                
                                
                                switch indexPath.row {
                                case 0:
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: SelectMyServicesVC.className) as! SelectMyServicesVC
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                case 1:
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: EarningsVC.className) as! EarningsVC
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                    
                                case 2:
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: ScheduelServicesVC.className) as! ScheduelServicesVC

                                    self.navigationController?.pushViewController(vc, animated: true)

                                case 3:
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CancelServicesVC.className) as! CancelServicesVC
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                    
                                default:
                                    print("do nothing...")
                                }
                                
                                /*  let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: SearchListVC.className) as! SearchListVC
                                 vc.headerTitle = self.categoryListVM?.categoryAtIndex(indexPath.row).title ?? String()
                                 
                                 vc.service_id = self.categoryListVM?.categoryAtIndex(indexPath.row).id ?? String()
                                 vc.lati = self.lati
                                 vc.longi = self.longi
                                 vc.profession = self.categoryListVM?.categoryAtIndex(indexPath.row).title ?? String()
                                 
                                 self.navigationController?.pushViewController(vc, animated: true)  */
                                
                            }
                        }
                       })
    }
    
    /*  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
     cell.contentView.backgroundColor = AppColor.highLightColor
     }
     }
     }
     
     func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .identity
     cell.contentView.backgroundColor = .clear
     
     let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerListVC.className) as! LawyerListVC
     if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
     vc.headerTitle = categoryVM.title
     }
     self.navigationController?.pushViewController(vc, animated: true)
     
     }
     }
     } */
    
    
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout extension
extension HomeVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 2, height: collectionView.frame.size.width / 2)
    }
}
