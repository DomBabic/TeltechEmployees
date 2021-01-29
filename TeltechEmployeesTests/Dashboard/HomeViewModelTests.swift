//
//  HomeViewModelTests.swift
//  TeltechEmployeesTests
//
//  Created by Dominik Babić on 29/01/2021.
//

import XCTest
import Combine
@testable import Networking
@testable import TeltechEmployees

fileprivate class RequestManagerStub: RequestManager {
    
    var shouldThrowError = true
    
    override func employeePublisher() -> AnyPublisher<[Employee], Error> {
        let errorPublisher = AnyPublisher(Result<[Employee], Error>.Publisher(URLError(.badURL)))
        let successPublisher = AnyPublisher(Result<[Employee], Error>.Publisher([Employee(department: "", name: "", surname: "", image: "", title: "", agency: "", intro: "", description: "")]))
        
        return shouldThrowError ? errorPublisher : successPublisher
    }
}

class HomeViewModelTests: XCTestCase {

    func testHomeViewModel() {
        let viewModel = HomeViewModel()
        
        let stub = RequestManagerStub()
        
        viewModel.requestManager = stub
        
        viewModel.fetchData()
        
        XCTAssertTrue(viewModel.errorOccurred)
        
        stub.shouldThrowError = false
        
        viewModel.fetchData()
        
        XCTAssertFalse(viewModel.errorOccurred)
        XCTAssertEqual(viewModel.employees.count, 1)
    }
}
