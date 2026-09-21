//
//  signupScreenViewmodel.swift
//  loginScreen
//
//  Created by Garima Gupta on 02/09/26.
//

import Observation
import Foundation

@MainActor
@Observable
class signupScreenViewmodel{
    
    private let authService = AuthService()
    
    
    // form user fields
    
    var firstName = ""
    var lastName = ""
    var userEmail = ""
    var companyName = ""
    var phoneNumber = ""
    var countryCode = "+1"
    var uniqueCode = ""
    
    // otp verification data
    
    var otp = ""
    let otpLength = 4
    
    var token = ""
    
    //ui states
    var showVerification = false
    var errorMessage = ""
    var navigateToPassword = false
    var otpSentMessage = ""
    var otpSentAlert: Bool = false
    var isLoading = false
    
    var companyStatus: CompanyType?
    
    //form validation
    
    var isValidForm: Bool {
        !self.firstName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !self.userEmail.trimmingCharacters(in: .whitespaces).isEmpty &&
        !self.companyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        !self.phoneNumber.trimmingCharacters(in: .whitespaces).isEmpty &&
        AuthManager.shared.isValidEmail(self.userEmail) &&
        AuthManager.shared.isValidPhoneNumber(self.phoneNumber)
    }
    
    var isValidOTP: Bool {
        self.otp.count == otpLength
    }
   
    
    //function for the footer button
    
    func handleFooterButton() {

        // Create Account showverification = false
        if showVerification == false {

            if !isValidForm {
                errorMessage = "*input all fields"
            } else {
                errorMessage = ""
                Task {
                    
                    self.isLoading = true
                    await self.requestOTPSignUp()
                    self.isLoading = false
                    
                }
            }

        // Verify & Continue showverification = true  screen appears for the user to enter the otp
        } else {
            if !isValidOTP {
                errorMessage = "*enter valid OTP"
            } else {
                Task {
                    
                    self.isLoading = true
                    await self.otpVerificationSignin()
                    self.isLoading = false
                    
                }
            }
        }
    }
    
    //update otp
    
    func updateOTP(_ newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        otp = String(filtered.prefix(otpLength))
    }
    
    // function to send the otp
    
    func requestOTPSignUp() async {

            let request = sendOtpRequest(
                email: self.userEmail,
                firstName: self.firstName,
                lastName: self.lastName,
                mode: "signup"
            )

            do {
                
                let response = try await authService.requestOTP(request: request)
                print("OTP sent successfully")
                self.errorMessage = ""
                self.showVerification = true
                self.otpSentAlert = true
                self.otpSentMessage = response.message

            } catch {

                
                print("OTP request failed")
                self.errorMessage = "Unable to send OTP"
                self.showVerification = false
                self.otpSentAlert = true
                self.otpSentMessage = "Unable to send OTP. Please try again."

            }
        }
    
    
    // verification of the otp
    
    
    func otpVerificationSignin() async {
        
        //making a json object request
        
        let request = otpVerificationRequest(
                                email: self.userEmail,
                                 otp: self.otp,
                                 deviceId: "postman-device-1",
                                 deviceName: "Postman")
            do{
                
                let response = try await authService.otpVerification(
                            request: request
                        )

                        // Store the token received from the backend
                        self.token = response.token

                        // Temporary: check that the token was received
                        print("Token received:", self.token)
                
                print("otp verification successfull")
                self.errorMessage = ""
                self.navigateToPassword = true
                
            } catch {
                print("otp verification failed")
                print("ERROR:", error)
                print("ERROR DESCRIPTION:", error.localizedDescription)

                self.errorMessage = "*invalid otp"
                self.navigateToPassword = false
            }
        
    }
    
   
}
