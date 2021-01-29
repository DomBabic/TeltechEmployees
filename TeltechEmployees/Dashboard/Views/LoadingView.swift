//
//  LoadingView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 29/01/2021.
//

import Foundation
import SwiftUI

struct LoadingView<Content: View>: View {
    let content: Content
    let gradient: Gradient
    
    @State var isAnimating = false
    
    private var animation: Animation {
        Animation.linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    init(gradient: Gradient, content: @escaping () -> Content) {
        self.gradient = gradient
        self.content = content()
    }
    
    var body: some View {
        VStack {
            
            Circle()
                .stroke(
                    LinearGradient(gradient: gradient,
                                   startPoint: .top,
                                   endPoint: .bottom),
                    style: StrokeStyle(lineWidth: 5,
                                       lineCap: .round)
                )
                .frame(width: 40, height: 40)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
                                    .animation(isAnimating ? animation : .default)
                                    .onAppear { isAnimating = true }
                                    .onDisappear { isAnimating = false }
            
            content
            
        }
    }
}
