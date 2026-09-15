//
//  authManager.swift
//  loginScreen
//
//  Created by Garima Gupta on 25/08/26.
//

import Foundation

class AuthManager {

    static let shared = AuthManager()

    private init() {}

    //function to check the validity of email entered by the user
    
    func isValidEmail(_ email: String) -> Bool {

            let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

            return email.range(
                of: emailRegex,
                options: .regularExpression
            ) != nil
        }
    
    // function to check the validity of the phone number
    
    func isValidPhoneNumber(_ phoneNumber: String) -> Bool{
        
        let phonenumberRegex = #"^[0-9]{10}$"#
        
        return phoneNumber.range(
            of: phonenumberRegex,
            options: .regularExpression
        ) != nil
    }
    
    // function for checking the strong password
    
    func strongPassword(_ password: String) -> Bool{
        
        let passwordRegex = #"^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>/?]).{8,}$"#
        
        return password.range(
            of: passwordRegex,
            options: .regularExpression
        ) != nil
    }
    
    // function for checking the length of the password to be eight
    
    func lengthPassword(_ password: String) -> Bool{
        
        let passwordRegex = #"^.{8,}$"#
        
        return password.range(
            of: passwordRegex,
            options: .regularExpression
        ) != nil
    }
    
    
    
}
