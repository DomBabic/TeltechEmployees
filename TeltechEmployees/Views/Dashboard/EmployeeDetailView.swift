//
//  EmployeeDetailView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 28/01/2021.
//

import Foundation
import SwiftUI
import Networking

struct EmployeeDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var coordinator = AppCoordinator.shared
    @ObservedObject var viewModel: EmployeeCardViewModel
    
    @State var bounds = UIScreen.main.bounds
    
    init(with employee: Employee) {
        self.viewModel = EmployeeCardViewModel(with: employee)
    }
    
    @ViewBuilder
    var body: some View {
        ScrollView {
            VStack {
                HStack(spacing: 16) {
                    buildImageView(isLoading: $viewModel.isLoadingImage.wrappedValue)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(alignment: .top) {
                            Text("Name:")
                                .foregroundColor(Color("textAccent"))
                            
                            Text($viewModel.name.wrappedValue)
                                .foregroundColor(Color("text"))
                        }
                        
                        HStack(alignment: .top) {
                            Text("Title:")
                                .foregroundColor(Color("textAccent"))
                            
                            Text($viewModel.title.wrappedValue)
                                .foregroundColor(Color("text"))
                        }
                    }
                }
                .padding(.horizontal, 16)
                
                Text($viewModel.intro.wrappedValue)
                    .foregroundColor(Color("text"))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                
                Text($viewModel.description.wrappedValue)
                    .foregroundColor(Color("text"))
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                
                Text("Close")
                    .frame(width: bounds.width * 0.8, height: 50, alignment: .center)
                    .background(Color("backgroundAccent"))
                    .foregroundColor(Color("text"))
                    .cornerRadius(25)
                    .padding(.vertical, 32)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }.padding(.top, 48)
        }
        .frame(width: bounds.width, height: bounds.height)
        .background(Color("background"))
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder func buildImageView(isLoading: Bool) -> some View {
        if $viewModel.isLoadingImage.wrappedValue {
            LoadingView(gradient: Gradient(colors: [Color("backgroundImage"),
                                                    Color.white])) {
                Text("Loading...")
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 8)
            }
            .frame(width: 128, height: 128, alignment: .center)
            .background(Color("backgroundImage"))
            .foregroundColor(Color("backgroundAccent"))
            .clipShape(Circle())
            .overlay(Circle().stroke(Color("backgroundImage"), lineWidth: 4))
        } else {
            Image(uiImage: $viewModel.image.wrappedValue)
                .resizable()
                .frame(width: 128, height: 128, alignment: .center)
                .aspectRatio(contentMode: .fill)
                .background(Color("backgroundImage"))
                .foregroundColor(Color("backgroundAccent"))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("backgroundImage"), lineWidth: 4))
        }
    }
}
