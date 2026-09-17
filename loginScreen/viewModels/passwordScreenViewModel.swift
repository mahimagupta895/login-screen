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
            self.errorMessage = "*password must contain at least one uppercase letter, one lowercase letter, one number, one special character"
            return
        }
        
        if self.password != self.confirmPassword {
            self.errorMessage = "*password does not match"
            return
        }
        
        
        
        self.errorMessage = ""
        
        Task{
            
            let accountCreateSuccess = await createAccountAPI()
            
            if accountCreateSuccess{
                print("navigating to the dashborad")
                navigateToDashboard = true
            }else{
                print("not able to set password")
            }
            
        }
    }
        
        //function specifically for hitting the api of the creating the password
        
        func createAccountAPI() async -> Bool {
            
            let request = createpasswordRequest(
                password: self.password,
                confirmPassword: self.confirmPassword)
            
            
            do {
                
                let response = try await authService.createPassword(
                    request: request,
                    token: parentViewModel.token)
                
                print("password set successfully")
                
                appStorageData.shared.accessToken = response.token
                appStorageData.shared.refreshToken = response.refreshToken
                            
                print("acess token: ", response.token )
                print("refresh token: ", response.refreshToken)
                
                return true
                
            } catch{
                
                print("password not set")
                self.errorMessage = "could not set password"
                return false
                
            }
            
        }
        
    }

