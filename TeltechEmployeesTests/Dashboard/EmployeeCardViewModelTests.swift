//
//  EmployeeCardViewModelTests.swift
//  TeltechEmployeesTests
//
//  Created by Dominik Babić on 29/01/2021.
//

import XCTest
import Combine
@testable import Networking
@testable import TeltechEmployees

fileprivate class RequestManagerStub: RequestManager {
    override func imagePublisher(for imageName: String) -> AnyPublisher<UIImage?, Error> {
        return AnyPublisher(Result<UIImage?, Error>.Publisher(UIImage()))
    }
}

class EmployeeCardViewModelTests: XCTestCase {

    func testEmployeeCardViewModel() {
        let placeholder = UIImage(systemName: "person.circle.fill")?.withRenderingMode(.alwaysTemplate)
        
        let name = "Charles Dexter"
        let surname = "Ward"
        let title = "Explorer"
        let intro = "Hello, I am Charles"
        let description = "I went insane!"
        
        let employee = Employee(department: "", name: name, surname: surname, image: "charlie", title: title, agency: "", intro: intro, description: description)
        
        let viewModel = EmployeeCardViewModel(with: employee)
        
        XCTAssertEqual(viewModel.name, name + " " + surname)
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.intro, intro)
        XCTAssertEqual(viewModel.description, description)
        XCTAssertEqual(viewModel.image, placeholder)
        
        viewModel.requestManager = RequestManagerStub()
        
        viewModel.loadData()
        
        XCTAssertNotEqual(viewModel.image, placeholder)
    }

}
