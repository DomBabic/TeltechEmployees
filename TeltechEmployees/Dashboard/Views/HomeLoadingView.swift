//
//  HomeLoadingView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 29/01/2021.
//

import Foundation
import SwiftUI

struct HomeLoadingView: View {
    
    @State var bounds = UIScreen.main.bounds
    
    @State var isAnimating = false
    
    private var animation: Animation {
        Animation.linear(duration: 1)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        VStack {
            LoadingView(gradient: Gradient(colors: [Color("backgroundAccent"),
                                                    Color("textAccent"),
                                                    Color("text")])) {
                Text("loading")
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
            .frame(width: bounds.width * 0.3, height: bounds.width * 0.3)
            .background(Color("backgroundAccent"))
            .cornerRadius(10)
        }
    }
}
