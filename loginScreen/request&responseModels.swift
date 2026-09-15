//
//  request&responseModels.swift
//  loginScreen
//
//  Created by Garima Gupta on 02/09/26.
//

//these are the parameters that backend is actually expecting

import Foundation

//request for the sign in request for already existing users

struct signinRequest: Codable {
    
    let email:String
    let password:String
    let deviceId:String
    let deviceName:String
   
}

//request for sending the otp

struct sendOtpRequest: Codable{
    
    let email:String
    let firstName: String
    let lastName: String
    let mode: String
    
}

//request for the verification of the otp on the sign up page for new users

struct otpVerificationRequest: Codable{
    
    let email: String
    let otp: String
    let deviceId:String
    let deviceName:String
    
}

//creating password api

struct createpasswordRequest: Codable{
    let password: String
    let confirmPassword: String
}

//creating account, main sign up api

struct createAccountRequest: Codable{
    let email: String
    let mode: String
    let firstName: String
    let lastName: String
    let phone: String
    let company: String
}


//token response after otp verification

struct otpTokenResponse: Codable{
    let token: String
    let expiresIn: Int

}

struct otpSendingResponse: Codable{
    let success: Bool
    let message: String
}

