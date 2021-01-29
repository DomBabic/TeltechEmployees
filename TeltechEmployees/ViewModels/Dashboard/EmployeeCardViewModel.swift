//
//  EmployeeCardViewModel.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation
import Networking
import SwiftUI
import Combine

class EmployeeCardViewModel: ObservableObject {
    
    var cancellable: Set<AnyCancellable> = []
    
    var requestManager = RequestManager.shared
    
    var employee: Employee
    
    @Published var name: String = ""
    @Published var title: String = ""
    @Published var intro: String = ""
    @Published var description: String = ""
    @Published var image: UIImage = UIImage()
    
    init(with employee: Employee) {
        self.employee = employee
        
        name = employee.name + " " + employee.surname
        title = employee.title
        intro = employee.intro
        description = employee.description
        
        let publisher = requestManager.imagePublisher(for: employee.image)
        
        publisher.sink(receiveCompletion: { _ in }, receiveValue: { [weak self] value in
            var image = UIImage()
            
            if let receivedImage = value ?? UIImage(systemName: "person.circle.fill") {
                image = receivedImage
            }
            
            self?.image = image
        }).store(in: &cancellable)
    }
}
