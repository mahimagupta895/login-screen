//
//  View+Overlay.swift
//  loginScreen
//
//  Created by Garima Gupta on 22/09/26.
//


import SwiftUI

extension View {

    func overlayPresentation<OverlayContent: View>(
        isPresented: Binding<Bool>,
        opacity: Double = 0.4,
        dismissOnTap: Bool = true,
        @ViewBuilder content: @escaping () -> OverlayContent
    ) -> some View {

        modifier(
            OverlayModifier(
                isPresented: isPresented,
                opacity: opacity,
                dismissOnTap: dismissOnTap,
                overlay: content
            )
        )
    }
}

