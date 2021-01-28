//
//  LoginView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 28/01/2021.
//

import Foundation
import SwiftUI

struct LoginView: View {
    
    @State var bounds = UIScreen.main.bounds
    
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack(spacing: 16) {
            
            Spacer()
            
            Text("Employee app").font(.title).foregroundColor(Color("text"))
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                TextField("Enter username...", text: $username)
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(AccentedTextFieldStyle())
                    
                SecureField("Enter password...", text: $password)
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(AccentedTextFieldStyle())
            }
            .frame(width: bounds.width * 0.5)
            
            Spacer()
            
            Text("Log in")
                .frame(width: 150, height: 50, alignment: .center)
                .background(Color("backgroundAccent"))
                .cornerRadius(25)
                .onTapGesture {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                    to: nil,
                                                    from: nil,
                                                    for: nil)
                    
                    AppCoordinator.shared.loginUser()
                }
            
            Spacer()
        }
        .frame(width: bounds.width, height: bounds.height)
        .background(Color("background"))
    }
}
