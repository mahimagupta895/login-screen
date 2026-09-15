//
//  passwordScreenViewModel.swift
//  loginScreen
//
//  Created by Garima Gupta on 08/09/26.
//
import SwiftUI
import Foundation
import Observation

@Observable
@MainActor
class passwordScreenViewModel{
    
    private let authService = AuthService()
    
    var parentViewModel: signupScreenViewmodel
    
    
    //form user fields
    
    var password = ""
    var confirmPassword = ""
    var errorMessage = ""
    var navigateToDashboard = false
    
    init(parentViewModel: signupScreenViewmodel) {
        self.parentViewModel = parentViewModel
    }
    
    
    //function for the footer button
    
    func createAccount() {
        
        if !AuthManager.shared.lengthPassword(self.password){
            self.errorMessage = "*password should be atleast 8 digit"
            return
        }
        
        if !AuthManager.shared.strongPassword(self.password){
            self.errorMessage = "*p assword must contain at least one uppercase letter, one lowercase letter, one number, one special character"
            return
        }
        
        if self.password != self.confirmPassword {
            self.errorMessage = "*password does not match"
            return
        }
        
        
        
        self.errorMessage = ""
        
        Task{
            
            let accountCreateSuccess = await createAccountAPI()
            
            print("navigating to the dashborad")
            navigateToDashboard = true
        }
        
        //function specifically for hitting the api of the creating the password
        
        func createAccountAPI() async -> Bool {
            
            let request = createpasswordRequest(
                password: self.password,
                confirmPassword: self.confirmPassword)
            
            
            do {
                
                try await authService.createPassword(
                    request: request,
                    token: parentViewModel.token)
                print("password set successfully")
                return true
                
            } catch{
                
                print("password not set")
                self.errorMessage = "could not set password"
                return false
            }
            
        }
        
        //main and final sign up api
        
        func signUpAPI(signupScreenViewModel: signupScreenViewmodel) async -> Bool{
            
            let request = createAccountRequest(
                email: signupScreenViewModel.userEmail,
                mode: "signup",
                firstName: signupScreenViewModel.firstName,
                lastName: signupScreenViewModel.lastName,
                phone: signupScreenViewModel.phoneNumber,
                company: signupScreenViewModel.companyName)
            
            do{
                
                try await authService.createAccount(request: request)
                print("account created successfully")
                self.errorMessage = ""
                return true
                
            }catch{
                
                if let nsError = error as NSError? {
                    self.errorMessage = nsError.localizedDescription
                }
                return false
                
            }
        }
        
    }
}
