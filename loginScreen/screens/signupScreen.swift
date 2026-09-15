//
//  signupScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 25/08/26.
//

import SwiftUI

struct signupScreen: View {
    
    @Environment(\.dismiss) var dismissSignupScreen
    @State private var resetScreen = false
    
    @State private var viewModel = signupScreenViewmodel()
    
    var body: some View {
        
        NavigationStack{
            
            ScrollView{
                
                VStack(alignment: .leading, spacing: 20){
                    
                    HStack{
                        
                        simplePlaceholder(userInput: self.$viewModel.firstName,
                                          placeHolderType: "First Name",
                                          promptText: "John" ,
                                          isRequired: true)
                        .disabled(self.viewModel.showVerification)
                        .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                        
                        simplePlaceholder(userInput: self.$viewModel.lastName,
                                          placeHolderType: "Last Name",
                                          promptText: "Doe",
                                          isRequired:  true)
                        .disabled(self.viewModel.showVerification)
                        .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                        
                    }
                    
                    emailPlaceholder(userMail: self.$viewModel.userEmail, isRequired: true)
                        .disabled(self.viewModel.showVerification)
                        .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                    
                    phonenumberPlaceholder(countryCode: self.$viewModel.countryCode,
                                           phoneNumber: self.$viewModel.phoneNumber,
                                           isRequired: true)
                    .disabled(self.viewModel.showVerification)
                    .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                    
                    
                    VStack(spacing: 6){
                        
                        Text("Company Type")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            
                            //button for the new company
                            Button{
                                self.viewModel.companyStatus = CompanyType.newCompany
                            }label: {
                                
                                if self.viewModel.companyStatus == CompanyType.newCompany{
                                    SelectedCompanyToggleCheck(companyStatus: CompanyType.newCompany.rawValue)
                                }else{
                                    UnselectedCompanyToggleCheck(companyStatus: CompanyType.newCompany.rawValue)
                                }
                                
                            }
                            
                            //button for the existing  company
                            Button{
                                self.viewModel.companyStatus = CompanyType.existingCompany
                            }label: {
                                
                                if self.viewModel.companyStatus == CompanyType.existingCompany{
                                    SelectedCompanyToggleCheck(companyStatus: CompanyType.existingCompany.rawValue)
                                }else{
                                    UnselectedCompanyToggleCheck(companyStatus: CompanyType.existingCompany.rawValue)
                                }
                            }.disabled(self.viewModel.showVerification)
                             .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                                
                        }
                    }
                    
                    //block for the flow of the new company
                    if self.viewModel.companyStatus == CompanyType.newCompany {
                        
                        simplePlaceholder(userInput: self.$viewModel.companyName,
                                          placeHolderType: "Company Name",
                                          promptText: "ABC Solar Inc.",
                                          isRequired: true)
                        .disabled(self.viewModel.showVerification)
                        .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                        
                        // otp verification block
                        
                        if self.viewModel.showVerification{
                            
                            Divider()
                            
                            HStack(alignment: .lastTextBaseline, spacing: 4){
                                
                                Text("We've sent a verification code to your email. Enter it below to continue.")
                                    .font(.system(size: 14))
                                    .multilineTextAlignment(.leading)
                                
                                Button{
                                    self.viewModel.showVerification = false
                                    
                                }label: {
                                    Text("Edit")
                                        .foregroundColor(appColors.buttonOrangeColor)
                                        .underline()
                                        .fontWeight(.bold)
                                }
                                
                            }
                            
                            otpPlaceholder(otp: self.$viewModel.otp)
                                .keyboardType(.numberPad)
                                .onChange(of: self.viewModel.otp){ newValue in
                                    viewModel.updateOTP(newValue)
                                }
                            
                            
                            HStack{
                                
                                Text("Don't recieve verification code?")
                                    .font(.system(size: 14))
                                Button{
                                    Task {
                                        await self.viewModel.requestOTPSignUp()
                                    }
                                }label: {
                                    Text("Resend")
                                        .font(.system(size: 13))
                                        .fontWeight(.bold)
                                        .foregroundColor(.orange)
                                        .underline()
                                    
                                }
                            }
                            
                            
                        }
                        
                        //block for the flow of the existing company
                    }else if self.viewModel.companyStatus == CompanyType.existingCompany{
                        
                        VStack(spacing: 5){
                            
                            simplePlaceholder(userInput: self.$viewModel.companyName,
                                              placeHolderType: "Company Name",
                                              promptText: "Auto-filled from unique code",
                                              isRequired: true)
                            .disabled(self.viewModel.showVerification)
                            .opacity(self.viewModel.showVerification ? 0.6 : 1.0)
                            
                            HStack{
                                
                                Image("exclamationIcon")
                                    .resizable()
                                    .renderingMode(.template)
                                    .background(.clear)
                                    .foregroundColor(.orange)
                                    .frame(width: 15, height: 15)
                                    .padding(.bottom)
                                
                                
                                Text("Enter your company's unique code. Your company name will be filled automatically")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(red: 0.616, green: 0.4, blue: 0.22))
                                    .font(.system(size: 14))
                                
                            }.padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                        .fill(Color(red: 1.00, green: 0.57, blue: 0.00))
                                        .opacity(0.2))
                            
                            simplePlaceholder(userInput: self.$viewModel.uniqueCode,
                                              placeHolderType: "Unique Code",
                                              promptText: " E.G SUN5678",
                                              isRequired: true)
                            
                        }
                        
                    }
                    
                }.padding(.horizontal, 20)
            }
            
            VStack(spacing: 5){
                
                Text(self.viewModel.errorMessage)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                //footer button
                footerButton(title: self.viewModel.showVerification ? "Verify & Continue" : "Create Account" ,
                             image: nil,
                             action: {self.viewModel.handleFooterButton()})
                .padding(.bottom, 10)
                
            }.padding(.horizontal, 20)
        }
         .navigationBarBackButtonHidden(false)
         .navigationTitle("Sign Up")
         .onAppear{ navigationTitleDesign() }
         .navigationDestination(isPresented: self.$viewModel.navigateToPassword)
        {
            passwordScreen(parentViewModel: viewModel)
        }
        
        .alert(self.viewModel.otpSentMessage, isPresented: self.$viewModel.otpSentAlert){
            Button("Ok", role: .cancel) { }
        }
        
        .alert(self.viewModel.otpSentMessage, isPresented: self.$viewModel.otpSentAlert)
        {
            Button(role: .cancel){
            }label: {
                Text("Try Again")
                    .foregroundColor(.red)
            }
        }
    }
}

