//
//  ValidationProtocol.swift
//  BU
//
//  Created by Aman Kumar on 17/01/21.
//

import Foundation
protocol ValidationProtocol {
    
    //TODO: Validate email
    func isValidEmail(_ email: String) -> Bool
    
    //TODO: Validate password
    func isValidPasssword(_ password: String) -> Bool
    
    //TODO: Validate phone number
    func isValidPhone(_ value: String) -> Bool
    
    //TODO: Validate indian phone count
    func isValidIndianPhoneCount(_ value: String) -> Bool
    
    //TODO: Validate indian phone count
    func isValidPasswordCount(_ value: String) -> Bool
    
    //TODO: Validate indian phone number
    func isValidIndianPhone(_ value: String) -> Bool
    
    //TODO: Validate zip code
    func isValidZipCode(_ value: String) -> Bool
    
    //TODO: Validate fullName
    func isValidFullName(_ fullName: String) -> Bool
    
    //TODO: Validate username
    func isValidUsername(_ username: String) -> Bool
    
    //TODO: Validate OTP count
    func isValidOTPCount(_ value: String) -> Bool
    
    //TODO: Validate empty field
    func checkEmptyField(_ value: String) -> Bool
    
   /* //TODO: Validate GSTIN number
    func isValidGSTIN(_ value: String) -> Bool */
}
