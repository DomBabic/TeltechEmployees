//
//  AppRootView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 28/01/2021.
//

import Foundation
import SwiftUI
import Networking

struct AppRootView: View {
    
    @ObservedObject var monitor = NetworkStatusMonitor.shared
    @ObservedObject var coordinator = AppCoordinator.shared
    @State var bounds = UIScreen.main.bounds
    
    @ViewBuilder
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                coordinator.scene(for: $coordinator.entryPoint.wrappedValue)
                    .edgesIgnoringSafeArea(.all)
                
                Text("No network connection.")
                    .foregroundColor(Color.white)
                    .edgesIgnoringSafeArea(.horizontal)
                    .frame(width: bounds.width * 0.8, height: 32)
                    .background(Color("backgroundImage"))
                    .cornerRadius(16)
                    .opacity(!monitor.isOnline ? 1.0 : 0.0)
                    .padding(.top, 16)
                    .animation(.easeIn)
            }
        }
        .frame(width: bounds.width, height: bounds.height)
        .edgesIgnoringSafeArea(.all)
    }
}
