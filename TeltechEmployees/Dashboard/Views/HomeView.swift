//
//  HomeView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 27/01/2021.
//

import Foundation
import SwiftUI
import Networking
import Analytics

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @State var bounds = UIScreen.main.bounds
    
    @ViewBuilder
    var body : some View {
        VStack(alignment: .center) {
            if !$viewModel.employees.wrappedValue.isEmpty {
                EmployeeCarousel(items: $viewModel.employees.wrappedValue)
            } else if $viewModel.errorOccurred.wrappedValue {
                HomeErrorView(action: retry)
            } else {
                HomeLoadingView()
            }
        }
        .frame(width: bounds.width, height: bounds.height)
        .background(Color("background"))
        .onAppear {
            EventTracker.shared.trackEvent("accessed_home")
        }
    }
    
    func retry() {
        viewModel.fetchData()
    }
}
