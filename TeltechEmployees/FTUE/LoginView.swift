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
        VStack {
            
            Spacer()
            
            Text("employees").font(.title).foregroundColor(Color("text"))
            
            Spacer()
            
            VStack(alignment: .center, spacing: 16) {
                TextField("enter_username", text: $username)
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(AccentedTextFieldStyle())
                    
                SecureField("enter_password", text: $password)
                    .foregroundColor(Color("text"))
                    .multilineTextAlignment(.center)
                    .textFieldStyle(AccentedTextFieldStyle())
            }
            .frame(width: bounds.width * 0.5)
            
            Spacer()
            
            Text("log_in")
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
        .frame(width: bounds.width)
        .background(Color("background"))
    }
}
