//
//  SelectServiceVC+UITableView.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
//MARK: - UITableViewDataSource extension
extension SelectServiceVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.className, for: indexPath) as? CategoriesTableViewCell else {
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
extension SelectServiceVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    
    /*  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
