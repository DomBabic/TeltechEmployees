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
    
    @ObservedObject var coordinator = AppCoordinator.shared
    @ObservedObject var viewModel: EmployeeCardViewModel
    
    @State var cardWidth: CGFloat
    
    init(with employee: Employee, width: CGFloat) {
        viewModel = EmployeeCardViewModel(with: employee)
        _cardWidth = State(initialValue: width)
    }
    
    @ViewBuilder
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
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
            
            Text($viewModel.name.wrappedValue)
                .foregroundColor(Color("text"))
                .font(.title)
            Text($viewModel.title.wrappedValue)
                .foregroundColor(Color("textAccent"))
                .font(.subheadline)
            Text("\"\($viewModel.intro.wrappedValue)\"")
                .foregroundColor(Color("text"))
                .padding(.top, 16)
            
            NavigationLink(
                destination: coordinator.scene(for: .home(route: .detail(employee: viewModel.employee))),
                label: {
                    Text("See more")
                        .foregroundColor(Color("textAccent"))
                })
        }
        .frame(width: cardWidth)
        .padding(.top, 16)
        .padding(.bottom, 16)
        .background(Color("backgroundAccent"))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .clipped()
    }
}
