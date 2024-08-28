//
//  SelectMyServicesVC+TableView.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 03/04/21.
//

import Foundation
import UIKit
//MARK: - UITableViewDataSource extension
extension SelectMyServicesVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
       return (self.services == nil) ? 0 : self.services?.numberOfSections ?? 0
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.services?.numberOfRowsInSection(section) ?? 0

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.className, for: indexPath) as? ServiceTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
       guard let info = services?.serviceAtIndex(indexPath.row) else {
            fatalError(ConstantTexts.noDataIndexPath)
        }
        
        cell.btnEditRef.addTarget(self, action: #selector(btnEditTapped), for: .touchUpInside)
        
        cell.configure(with: info)
        
        return cell
    }
}



//MARK: - UITableViewDelegate extension
extension SelectMyServicesVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 171
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 171
    }
    
    /* func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoriesTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        if var selected = self.categoryListVM?.categories[indexPath.row]{
            if selected.isSelected{
                selected.togleIsSelected(value: Bool())
            }else{
                selected.togleIsSelected(value: true)
            }
        }
        
        cell.imgSetting.backgroundColor =  (self.categoryListVM?.categories[indexPath.row].isSelected ?? Bool()) ? AppColor.app_theame_color : AppColor.whiteColor
           
    }
    
    
      func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 196
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
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
