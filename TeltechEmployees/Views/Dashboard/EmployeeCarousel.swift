//
//  EmployeeCarousel.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 27/01/2021.
//

import Foundation
import SwiftUI
import Networking

struct EmployeeCarousel: View {
    var items: [Employee]
    
    @ObservedObject var coordinator = AppCoordinator.shared
    
    @State var currentIndex: Int = 0
    @State var width: CGFloat = UIScreen.main.bounds.width
    @State var cardWidth: CGFloat = UIScreen.main.bounds.width - 32
    @State var xOffset: CGFloat = 0
    @State var spacing: CGFloat = 16
    
    init(items: [Employee]) {
        self.items = items
        
        _xOffset = State(initialValue: calculateOffset())
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(spacing: spacing) {
                ForEach(items) { element in
                    EmployeeCardView(with: element, width: cardWidth)
                }
            }
            .frame(width: width)
            .offset(x: xOffset)
            .animation(.spring(), value: xOffset)
            .gesture(DragGesture()
                        .onChanged { value in
                            xOffset = calculateOffset() + value.translation.width
                        }
                        .onEnded { value in
                            let swipeTreshhold: CGFloat = 100
                            let swipedWidth = value.translation.width
                            
                            if swipedWidth > 0 {
                                if swipedWidth >= swipeTreshhold && currentIndex > 0 {
                                    currentIndex -= 1
                                }
                            } else {
                                if -swipedWidth >= swipeTreshhold && currentIndex < items.count - 1 {
                                    currentIndex += 1
                                }
                            }
                            
                            xOffset = calculateOffset()
                        })
            
            Spacer()
        }
    }
    
    private func calculateOffset() -> CGFloat {
        let step = cardWidth + spacing
        let count = CGFloat(items.count)
        let contentSize = step * count - spacing
        
        let offset = (contentSize - width) / 2
        
        return offset + spacing - (step * CGFloat(currentIndex))
    }
    
}
