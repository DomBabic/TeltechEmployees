//
//  ContentView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 26/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)
            }
            .navigationBarTitle("Hello", displayMode: .inline)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
