//
//  user.swift
//  loginScreen
//
//  Created by Garima Gupta on 31/08/26.
//

import SwiftData

@Model

class User {
    
    var firstName: String
    var lastName: String
    var userEmail: String
    var companyName: String
    var phoneNumber: String
    
    init(
        firstName: String,
        lastName: String,
        userEmail: String,
        companyName: String,
        phoneNumber: String
    ){
        self.firstName = firstName
        self.lastName = lastName
        self.userEmail = userEmail
        self.companyName = companyName
        self.phoneNumber = phoneNumber
    }
        
    
}
