//
//  BankDetailsVC+UITextField.swift
//  BU_PROVIDER
//
//  Created by Aman Kumar on 02/04/21.
//

import Foundation
import UIKit
//MARK: - UITextFieldDelegate extension
extension BankDetailsVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = customMethodManager?.getIndexPathFor(view: textField, tableView: self.tblIDProof) else { return true }
        let lastRowIndex = self.tblIDProof.numberOfRows(inSection: 0) - 1
        if currentIndexPath.row != lastRowIndex {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            while nextIndexPath.row <= lastRowIndex {
                if let nextCell = self.tblIDProof.cellForRow(at: nextIndexPath) as? Auth_TextField_TableViewCell {
                    self.tblIDProof.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
                    nextCell.textFieldFloating?.returnKeyType = .next
                    if nextIndexPath.row == lastRowIndex {
                        nextCell.textFieldFloating?.returnKeyType = .done
                    }
                    nextCell.textFieldFloating?.becomeFirstResponder()
                    break
                }
            }
            textField.resignFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        let str = textField.text as String?
        if let index = customMethodManager?.getIndexPathFor(view: textField, tableView: self.tblIDProof) {
            if str?.count == 0 {
                
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = String()
            }
            else{
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = str ?? String()
            }
        }
    }
    
}
