//
//  DrawerVC+UITableViewDataSourceDelegate.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/03/21.
//

import Foundation
import UIKit
//MARK: - UITableViewDataSource extension
extension DrawerVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.className, for: indexPath) as? SettingsTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        guard let info = categoryListVM?.categoryAtIndex(indexPath.row) else {
            fatalError(ConstantTexts.noDataIndexPath)
        }
        cell.configure(with: info)
        
        return cell
    }
}



//MARK: - UITableViewDelegate extension
extension DrawerVC:UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: SelectServiceVC.className) as! SelectServiceVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else if indexPath.row == 1{
            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: ServiceHistoryVC.className) as! ServiceHistoryVC
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 2{
            
        }else if indexPath.row == 3{
            
        }else{
            self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.WantToLogoutALERT, btnOkTitle: ConstantTexts.OkBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                if status{
                    self.hitLogOutService()
                    
                }
            })
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 196
    }
    
   /* func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 245
    } */
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
}
