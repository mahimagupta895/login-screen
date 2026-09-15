//
//  signinScreenViewModel.swift
//  loginScreen
//
//  Created by Garima Gupta on 02/09/26.
//

import Foundation
import Observation

@Observable
class signinScreenViewModel{
    
    //user input
    
    var userMail = ""
    var signinPassword = ""
    
    //UI state
    
    var errorMessage = ""
    var isLoading = false
    var navigateToHomeScreen = false
    
    //api integration
    
    private let authService = AuthService()
    
    
    
    //function for the sign in button
    
    func signin(){
        
        if userMail.isEmpty{
            errorMessage = "*Please enter your email"
            return
        }
        
        if signinPassword.isEmpty{
            errorMessage = "*Please enter your password"
            return
        }
        
        errorMessage = ""
        
        //creating request
        let request = signinRequest(email: self.userMail,
                                   password: self.signinPassword,
                                   deviceId: "postman-device-1",
                                   deviceName: "iphone 14")
        
        self.isLoading = true
        
        Task{
            do{
                
                try await authService.signin(request: request)
                print("login api successfull")
                self.isLoading = false
                self.navigateToHomeScreen = true
                
                
            }catch{
                
                print("Login API failed:", error)
                self.isLoading = false
                errorMessage = error.localizedDescription
                self.navigateToHomeScreen = false
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
