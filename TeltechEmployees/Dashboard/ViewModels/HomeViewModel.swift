//
//  HomeViewModel.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 27/01/2021.
//

import Foundation
import Combine
import Networking

class HomeViewModel: ObservableObject {
    
    var requestManager = RequestManager.shared
    
    var cancellable: Set<AnyCancellable> = []
    
    @Published var errorOccurred = false
    @Published var employees: [Employee] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        errorOccurred = false
        
        let publisher = requestManager.employeePublisher()
        
        publisher.sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.errorOccurred = false
            case .failure(_):
                self?.errorOccurred = true
            }
        }, receiveValue: { [weak self] value in
            self?.employees = value
        })
        .store(in: &cancellable)
    }
}
