//
//  OnBoardingVC+TableView.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 31/03/21.
//

import Foundation
import UIKit
//MARK: - UITableViewDataSource extension
extension OnBoardingVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataListVM == nil) ? 0 : self.dataListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OnboardingTableViewCell.className, for: indexPath) as? OnboardingTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        guard let info = dataListVM?.dataStoreStructAtIndex(indexPath.row) else {
            fatalError(ConstantTexts.noDataIndexPath)
        }
        cell.configure(with: info)
        
        return cell
    }
}



//MARK: - UITableViewDelegate extension
extension OnBoardingVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let userData = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        if indexPath.row == 0{
            
            
            if userData.status == "idproof" || userData.status == "personaldetails" || userData.status == "address" || userData.status == "declaration"{
                let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: IDProofVC.className) as! IDProofVC
                vc.isComingForEditing = true
                vc.callBackID = { [weak self] in
                    self?.dataListVM?.onboardingDataList[0].status = true
                    DispatchQueue.main.async {
                        self?.obTableView.reloadData()
                    }
                }
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            
            
            
        }else if indexPath.row == 1{
            
            if userData.status == "personaldetails" || userData.status == "address"  || userData.status == "declaration"{
                
                let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: PersonalDetailsVC.className) as! PersonalDetailsVC
                vc.isComingForEditing = true
                vc.callBackPersonal = { [weak self] in
                    self?.dataListVM?.onboardingDataList[0].status = true
                    self?.dataListVM?.onboardingDataList[1].status = true
                    DispatchQueue.main.async {
                        self?.obTableView.reloadData()
                    }
                }
                
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if indexPath.row == 2{
            if userData.status == "address"  || userData.status == "declaration"{
                let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: AddAddreessVC.className) as! AddAddreessVC
                vc.isComingForEditing = true
                    vc.callBackAddress = { [weak self] in
                        self?.dataListVM?.onboardingDataList[0].status = true
                        self?.dataListVM?.onboardingDataList[1].status = true
                        self?.dataListVM?.onboardingDataList[2].status = true
                        DispatchQueue.main.async {
                            self?.obTableView.reloadData()
                        }
                    }
                    
                   self.navigationController?.pushViewController(vc, animated: true)
                    
            }
        }else if indexPath.row == 3{
            if  userData.status == "declaration"{
                
                let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: DeclarationVC.className) as! DeclarationVC
                    vc.isComingForEditing = true
                    vc.callBackDec = { [weak self] in
                        self?.dataListVM?.onboardingDataList[0].status = true
                        self?.dataListVM?.onboardingDataList[1].status = true
                        self?.dataListVM?.onboardingDataList[2].status = true
                        self?.dataListVM?.onboardingDataList[3].status = true
                        DispatchQueue.main.async {
                            self?.obTableView.reloadData()
                        }
                    }
                    
                    
                    
                   self.navigationController?.pushViewController(vc, animated: true)
                    
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 204
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        footer.lblSignUpRef.isHidden = true
        footer.btnContinueRef.setTitle(ConstantTexts.Proceed_BT, for: .normal)
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 135
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
}
