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
            ZStack {
                coordinator.scene(for: $coordinator.entryPoint.wrappedValue)
                
                Text("no_network_connection")
                    .foregroundColor(Color.white)
                    .edgesIgnoringSafeArea(.horizontal)
                    .frame(width: bounds.width * 0.8, height: 32)
                    .background(Color("backgroundImage"))
                    .cornerRadius(16)
                    .opacity(!monitor.isOnline ? 1.0 : 0.0)
                    .padding(.top, 16)
                    .animation(.easeIn)
                    .position(x: bounds.width * 0.5, y: bounds.height * 0.125)
            }
            .frame(width: bounds.width, height: bounds.height)
            .edgesIgnoringSafeArea(.vertical)
            .background(Color("background"))
        }
        .frame(width: bounds.width, height: bounds.height)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
