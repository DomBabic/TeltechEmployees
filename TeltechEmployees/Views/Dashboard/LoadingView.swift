//
//  LoadingView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 29/01/2021.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    
    @State var bounds = UIScreen.main.bounds
    
    @State var isAnimating = false
    
    private var animation: Animation {
        Animation.linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 8) {
                Circle()
                    .stroke(
                        LinearGradient(gradient: Gradient(colors: [Color("backgroundAccent"),
                                                                   Color("textAccent"),
                                                                   Color("text")]),
                                       startPoint: .top, endPoint: .bottom),
                        style: StrokeStyle(
                            lineWidth: 5,
                            lineCap: .round
                        )
                    )
                    .frame(width: 40, height: 40)
                    .rotationEffect(Angle(degrees: isAnimating ? 360 : 0.0))
                                        .animation(isAnimating ? animation : .default)
                                        .onAppear { isAnimating = true }
                                        .onDisappear { isAnimating = false }
                
                Text("Loading...")
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
            .frame(width: bounds.width * 0.3, height: bounds.width * 0.3)
            .background(Color("backgroundAccent"))
            .cornerRadius(10)
        }
        .frame(width: bounds.width, height: bounds.height)
        .background(Color("background"))
    }
}
