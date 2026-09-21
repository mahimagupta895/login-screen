//
//  passwordScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 27/08/26.
//

import SwiftUI

struct passwordScreen: View {
    
   
    @State var showPassword = false
    @State var showConfirmPassword = false
    @State private var viewModel: passwordScreenViewModel
    
    
    let parentViewModel: signupScreenViewmodel
    
    // Give me the Signup ViewModel, and I'll use it to create my Password ViewModel.
    
    init(parentViewModel: signupScreenViewmodel) {
            self.parentViewModel = parentViewModel

            _viewModel = State(
                initialValue: passwordScreenViewModel(
                    parentViewModel: parentViewModel
                )
            )
        }
    
    var body: some View {
        
        ZStack{
            
            VStack(alignment: .leading, spacing:16){
                
                Text("Create a secure password for your account.")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.27, green: 0.27, blue: 0.31))
                    .fontWeight(.regular)
                
                passwordPlaceholder(password: self.$viewModel.password,
                                    passwordState: "Create Password",
                                    promptText: "Enter your password",
                                    showPassword: $showPassword, isRequired: true)
                
                passwordPlaceholder(password: self.$viewModel.confirmPassword,
                                    passwordState: "Confirm Password",
                                    promptText: "Re-enter your password",
                                    showPassword: $showConfirmPassword,
                                    isRequired: true)
                
                Spacer()
                
                Text(self.viewModel.errorMessage)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                footerButton(title: "Continue",
                             image: nil,
                             action: {self.viewModel.createAccount()})
                
                
            }.padding(16)
                .navigationTitle("Create Your Password")
                .navigationBarBackButtonHidden(false)
                .onAppear{ navigationTitleDesign() }
                .navigationDestination(
                    isPresented: self.$viewModel.navigateToDashboard
                ) {
                    homeDashboard()
                }
            
            if self.viewModel.isLoading{
                loader()
            }
            
        }
    }
}

