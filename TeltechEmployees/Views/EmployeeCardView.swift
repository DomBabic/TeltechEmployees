//
//  EmployeeCardView.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation
import SwiftUI
import Networking

struct EmployeeCardView: View {
    
    @ObservedObject var viewModel: EmployeeCardViewModel
    
    init(with employee: Employee) {
        viewModel = EmployeeCardViewModel(with: employee)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            //TODO: Lazy load image from API
            Image(systemName: "")
                .resizable()
                .frame(width: 128, height: 128, alignment: .center)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color("backgroundAccent"))
                .background(Color("backgroundImage"))
                .clipShape(Circle())
                .clipped()
            VStack {
                Text($viewModel.name.wrappedValue)
                    .foregroundColor(Color("text"))
                    .font(.title)
                Text($viewModel.title.wrappedValue)
                    .foregroundColor(Color("textAccent"))
                    .font(.subheadline)
                Text("\"\($viewModel.intro.wrappedValue)\"")
                    .foregroundColor(Color("text"))
                    .padding(.top, 16)
            }
            .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        }
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
        .background(Color("backgroundAccent"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .clipped()
    }
}

struct EmployeeListItemView_Previews: PreviewProvider {
    static var previews: some View {
        let jsonString = "{\"department\":\"executive team\",\"name\":\"Patrick\",\"surname\":\"Falzon\",\"image\":\"patrick\",\"title\":\"General Manager\",\"agency\":\"\",\"intro\":\"Hello, I'm Patrick.\",\"description\":\"As General Manager, my role is made easy by the rest of the amazing team here at Teltech, where our goal is to deliver forward-thinking and user-friendly mobile solutions that focus on security, practicality and innovation. In my free time, I enjoy travel, reading and long walks on the beach (with my dog, of course).\"}"
        
        let decoder = JSONDecoder()
        
        let data = jsonString.data(using: .utf8)!
        let employee = try! decoder.decode(Employee.self, from: data)
        
        return EmployeeCardView(with: employee)
            .preferredColorScheme(.dark)
    }
}
