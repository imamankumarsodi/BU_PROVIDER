//
//  ValidationClass.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
class ValidationClass:ValidationProtocol {
    
    //TODO: Singleton object
    static let shared = ValidationClass()
    private init() {}
    
    //TODO: Validate email
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    //TODO: Validate password
    func isValidPasssword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: password)
    }
    
    //TODO: Validate phone number
    func isValidPhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    
    //TODO: Validate indian phone count
    func isValidIndianPhoneCount(_ value: String) -> Bool {
        return value.count >= 10 ? true : false
    }
    
    //TODO: Validate indian phone count
    func isValidPasswordCount(_ value: String) -> Bool {
        return value.count >= 6 ? true : false
    }
    
    
    //TODO: Validate indian phone number
    func isValidIndianPhone(_ value: String) -> Bool {
        let PHONE_REGEX = "^([+][9][1]|[9][1]|[0]){0,1}([7-9]{1})([0-9]{9})$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    //TODO: Validate zip code
    func isValidZipCode(_ value: String) -> Bool {
        let ZIP_REGEX = "^\\d{5}(?:[-\\s]\\d{4})?$"
        let zipTest = NSPredicate(format: "SELF MATCHES %@", ZIP_REGEX)
        let result =  zipTest.evaluate(with: value)
        return result
    }
    
    
    
    
    
    //TODO: Validate fullName
    func isValidFullName(_ fullName: String) -> Bool {
        return fullName.count > 1 ? true : false
    }
    
    
    //TODO: Validate username
    func isValidUsername(_ username: String) -> Bool {
        
        let regularExpressionText = "^[ء-يa-zA-Z0-9_.-]+"
        let regularExpression = NSPredicate(format:"SELF MATCHES %@", regularExpressionText)
        return regularExpression.evaluate(with: username)
    }
    
    
    //TODO: Validate OTP count
    func isValidOTPCount(_ value: String) -> Bool {
        return value.count >= 6 ? true : false
    }
    
    //TODO: Validate empty field
    func checkEmptyField(_ value: String) -> Bool{
        return value.count > 0 ? true : false
    }
    
    
  /*  //TODO: Validate GSTIN number
    func isValidGSTIN(_ value: String) -> Bool {
        let GSTIN_REGEX = "^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$"
        let gstinTest = NSPredicate(format: "SELF MATCHES %@", GSTIN_REGEX)
        let result =  gstinTest.evaluate(with: value)
        return result
    }
    
    */
}
