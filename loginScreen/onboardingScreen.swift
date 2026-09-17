//
//  hasSeenOnboardingScreen.swift
//  loginScreen
//
//  Created by Garima Gupta on 16/09/26.
//

import SwiftUI

struct hasSeenOnboardingScreen: View {
    
    @AppStorage("hasSeenOnboarding")
    private var hasSeenOnboarding = false
    
    @State private var navigateToMainScreen = false
    
    
    var body: some View {
         
        NavigationStack{
            
            Text("this is onboarding screen")
            
            Button{
                self.hasSeenOnboarding = true
                self.navigateToMainScreen = true
            }label:{
                Text("get started")
            }
        }.navigationBarBackButtonHidden()
            .navigationDestination(
                isPresented: self.$navigateToMainScreen){mainLoginScreen()}
          
        
    }
}

