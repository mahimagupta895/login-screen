//
//  demo.swift
//  loginScreen
//
//  Created by Garima Gupta on 29/09/26.
//

import SwiftUI

struct demo: View {
    var body: some View {
        
        Text("Hello, World!")
        
        Circle()
            .trim(from: 0.6, to: 1)
            .fill(.pink)
        
        Image(systemName: "person.crop.circle")
            .resizable()
            .foregroundColor(.red)
            .frame(width: 400, height: 400)
            .background()
    }
}

#Preview {
    demo()
}
