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
    @Published var image: UIImage = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate) ?? UIImage()
    @Published var isLoadingImage = true
    
    init(with employee: Employee) {
        self.employee = employee
        
        name = employee.name + " " + employee.surname
        title = employee.title
        intro = employee.intro
        description = employee.description
        
        let publisher = requestManager.imagePublisher(for: employee.image)
        
        publisher.sink(receiveCompletion: { [weak self] _ in
            self?.isLoadingImage = false
        }, receiveValue: { [weak self] value in
            if let receivedImage = value {
                self?.image = receivedImage
            }
        }).store(in: &cancellable)
    }
}
