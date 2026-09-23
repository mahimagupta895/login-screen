//
//  overlayModifier.swift
//  loginScreen
//
//  Created by Garima Gupta on 22/09/26.
//
import SwiftUI

struct OverlayModifier<overlayContent: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    let opacity: Double
    let dismissOnTap: Bool
    
    @ViewBuilder var overlay: () -> overlayContent
    
    func body(content: Content) -> some View{
        
        ZStack{
            
            content
            
            if isPresented{
                
                DimmingOverlay(opacity: opacity, dismissOnTap: dismissOnTap){
                    isPresented = false}
                
                overlay()
                    
                    .zIndex(2)
                
            }
        }
    }
    
}
