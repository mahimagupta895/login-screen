//
//  signinScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 21/08/26.
//

import SwiftUI

struct signinScreen: View {
    
    @State private var viewModel = signinScreenViewModel()
    @State private var showPassword = false
    
    var body: some View {
        
        ZStack{
            
            NavigationStack{
                
                    VStack(alignment:.leading, spacing: 20){
                        
                        Text("Enter your email and password to sign in.")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, -10)
                        
                        emailPlaceholder(userMail: self.$viewModel.userMail, isRequired: true)
                            .padding(.horizontal, -12)
                        
                        passwordPlaceholder(password: self.$viewModel.signinPassword,
                                            passwordState: "Password",
                                            promptText: "Enter your password",
                                            showPassword: $showPassword, isRequired: true)
                        .padding(.horizontal, -12)
                        
                        Button {
                            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                        } label: {
                            Text("Forgot password?")
                                .foregroundColor(Color(red: 1.00, green: 0.57, blue: 0.00))
                                .fontWeight(.bold)
                                .underline()
                        }.frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Spacer()
                        
                        Text(self.viewModel.errorMessage)
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                        
                        footerButton(title: "Sign In",
                                     image: nil,
                                     action: {self.viewModel.signin()})
                        .disabled(self.viewModel.isLoading)
                        .opacity(self.viewModel.isLoading ? 0.6 : 1.0)
                        
                        
                    }.padding(30)
                        .navigationBarBackButtonHidden(false)
                        .navigationTitle("Sign In")
                        .onAppear{ navigationTitleDesign() }
                        .navigationDestination(isPresented: self.$viewModel.navigateToHomeScreen){homeDashboard()}
                    
                    
                }
            
            if self.viewModel.isLoading{
                loader()
            }
            
        }
    }
}



