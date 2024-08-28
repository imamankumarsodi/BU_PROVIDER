//
//  PersonalDetailsVC+TableView.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 01/04/21.
//

import Foundation
import UIKit
//MARK: - UITableViewDataSource extension
extension PersonalDetailsVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.dataListVM == nil) ? 0 : self.dataListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IDProofTableViewCell.className, for: indexPath) as? IDProofTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.textFieldFloating.delegate = self
        
        guard let info = dataListVM?.dataStoreStructAtIndex(indexPath.row) else {
            fatalError(ConstantTexts.noDataIndexPath)
        }
        
        cell.btnDDRef.tag = indexPath.row
        cell.btnDDRef.addTarget(self, action: #selector(btnDDTapped), for: .touchUpInside)
        
        cell.configure(with: info)
        
        
        if indexPath.row == 2{
            cell.textFieldFloating?.inputAccessoryView = pickerToolbar
            cell.textFieldFloating.inputView = datePicker
        }else{
            cell.textFieldFloating?.inputAccessoryView = nil
            cell.textFieldFloating.inputView = nil
        }
        
        return cell
    }
}



//MARK: - UITableViewDelegate extension
extension PersonalDetailsVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
