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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 128, height: 128, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .background(Color("backgroundImage"))
                        .foregroundColor(Color("background"))
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("backgroundImage"), lineWidth: 4))
                    
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
                .padding(.all, 16)
                
                Text($viewModel.intro.wrappedValue)
                    .foregroundColor(Color("text"))
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                
                Text($viewModel.description.wrappedValue)
                    .foregroundColor(Color("text"))
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                
            }
            .padding(.all, 16)
            
            Spacer()
            
            Text("Close")
                .frame(width: bounds.width * 0.8, height: 50, alignment: .center)
                .background(Color("backgroundAccent"))
                .foregroundColor(Color("text"))
                .cornerRadius(25)
                .padding(.bottom, 32)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
        }
        .navigationBarBackButtonHidden(true)
        .frame(width: bounds.width, height: bounds.height)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}
