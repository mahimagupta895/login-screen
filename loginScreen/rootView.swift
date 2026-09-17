//
//  rootView.swift
//  loginScreen
//
//  Created by Garima Gupta on 16/09/26.
//
import SwiftUI

struct rootView: View {
    
    @AppStorage("hasSeenOnboarding")
    private var hasSeenOnboarding = false
    
    @State private var authManager = AuthManager.shared
    
    var body: some View{
        
        //for a new user, user has not seen onboarding
        if hasSeenOnboarding == false {
            
            hasSeenOnboardingScreen()
            
        //user has seen onboarding
        }else{
            
            if appStorageData.shared.accessToken.isEmpty {
                
                mainLoginScreen()
                
            }else{
                
                homeDashboard()
                
            }
        }
    }
    
}
