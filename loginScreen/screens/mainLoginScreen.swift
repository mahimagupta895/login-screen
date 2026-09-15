//
//  mainLoginScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 21/08/26.
//

import SwiftUI

struct mainLoginScreen: View {
    
    @State private var navigateToSignIn = false
    @State private var navigateToSignUp = false
    
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                    Color.white
                        .ignoresSafeArea()
                    
                    VStack(){
                        
                        Image("mainLogo")
                            .resizable()
                            .frame(width: 180, height: 250)
                            .scaledToFit()
                            .padding(.bottom, -100)
                            .padding(.top, 20)
                        
                        Text("SolarAgentHub")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("Powering the solar revolution, one digital worker at a time")
                            .foregroundColor(.gray)
                            .fontWeight(.regular)
                            .lineLimit(2)
                            .padding(.horizontal, 20)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        loginBlock(loginType: "Google", loginLogoImage: "googleLogo")
                            .padding(.top, 250)
                            
                        
                        loginBlock(loginType: "Apple", loginLogoImage: "appleLogo")
                            .padding(.bottom, 10)
                            
                        
                        HStack{
                            
                            Text("If you have an account?")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                            
                            Button{
                                navigateToSignIn = true
                            }label: {
                                Text("Sign in")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                    .underline()
                            }
                            
                        }
                        
                        
                        HStack{
                            
                            Text("Don't have an account?")
                                .font(.system(size: 13))
                                .fontWeight(.regular)
                                .foregroundColor(.gray)
                            
                            Button{
                                navigateToSignUp = true
                            }label: {
                                Text("Sign up")
                                    .font(.system(size: 13))
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                    .underline()
                            }
                            
                        }.padding(.bottom, 40)
                        
                        Spacer()
                        
                        HStack{
                            
                            Text("Privacy Policy")
                                .foregroundColor(.gray)
                                .font(.system(size:12))
                                .fontWeight(.medium)
                            
                            Text("|")
                                .foregroundColor(.gray)
                                .font(.system(size:12))
                                .fontWeight(.medium)
                            
                            Text("Terms & Conditions")
                                .foregroundColor(.gray)
                                .font(.system(size:12))
                                .fontWeight(.medium)
                        }
                        
                        .navigationDestination(isPresented: $navigateToSignIn){signinScreen()}
                        .navigationDestination(isPresented: $navigateToSignUp){signupScreen()}
                            
                        
                    }
                        
                }
            }
        
    }
}


