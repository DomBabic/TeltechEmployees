//
//  HomeView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 27/01/2021.
//

import Foundation
import SwiftUI
import Networking

struct HomeView: View {
    
    @ObservedObject var viewModel = HomeViewModel()
    
    @ViewBuilder
    var body : some View {
        VStack {
            if !$viewModel.employees.wrappedValue.isEmpty {
                EmployeeCarousel(items: $viewModel.employees.wrappedValue)
            } else if $viewModel.errorOccurred.wrappedValue {
                ErrorView(action: retry)
            } else {
                LoadingView()
            }
        }
        .background(Color("background").edgesIgnoringSafeArea(.vertical))
        .animation(.spring())
    }
    
    func retry() {
        viewModel.fetchData()
    }
}
