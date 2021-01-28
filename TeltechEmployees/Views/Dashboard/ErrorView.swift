//
//  ErrorView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 27/01/2021.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    @State var action: () -> Void
    
    init(action: @escaping () -> Void) {
        self._action = State(initialValue: action)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Something went wrong. Please try again.")
            
            Image(systemName: "arrow.counterclockwise.circle.fill")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .foregroundColor(Color("text"))
                .onTapGesture {
                    action()
                }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}
