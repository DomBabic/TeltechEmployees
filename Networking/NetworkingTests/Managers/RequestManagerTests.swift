//
//  RequestManagerTests.swift
//  NetworkingTests
//
//  Created by Dominik Babić on 26/01/2021.
//

import XCTest
import Networking
import Combine

fileprivate class EndpointStub: Endpoint {
    var shouldReturnNil = true
    
    override var url: URL? {
        get {
            shouldReturnNil ? nil : URL(string: "https://teltech.co/api")
        }
    }
}

class RequestManagerTests: XCTestCase {

    func testPublisher() {
        var expectation = XCTestExpectation(description: "Result Expectation")
        
        let endpoint = EndpointStub(path: "/api", queryItems: [])
        
        var cancellable: Set<AnyCancellable> = []
        var publisher = RequestManager.shared.publisher(for: endpoint, with: [Employee].self)
        
        var didFail = false
        
        //Assert badURL error is thrown, Endpoint.url is nil
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                XCTAssertEqual(error as? URLError, URLError(.badURL))
                didFail = true
            }
            
            expectation.fulfill()
        }, receiveValue: { value in
            
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(didFail)
        
        //Reset
        expectation = XCTestExpectation(description: "Result Expectation")
        didFail = false
        
        //Assert call finished, no badURL error
        endpoint.shouldReturnNil = false
        
        var finished = false
        
        publisher = RequestManager.shared.publisher(for: endpoint, with: [Employee].self)
        
        publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                finished = true
            case .failure(_):
                break
            }
            
            expectation.fulfill()
        }, receiveValue: { value in
            
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(finished)
    }
    
    func testEmployeePublisher() {
        let expectation = XCTestExpectation(description: "Result Expectation")
        
        var cancellable: Set<AnyCancellable> = []
        let publisher = RequestManager.shared.employeePublisher()
        
        var requestMade = false
        
        publisher.sink(receiveCompletion: { completion in
            requestMade = true
            
            expectation.fulfill()
        }, receiveValue: { value in
            
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(requestMade)
    }
    
    func testImagePublisher() {
        var expectation = XCTestExpectation(description: "Result Expectation")
        
        var cancellable: Set<AnyCancellable> = []
        var publisher = RequestManager.shared.imagePublisher(for: "-80")
        
        var requestMade = false
        
        publisher.sink(receiveCompletion: { completion in
            requestMade = true
            
            expectation.fulfill()
        }, receiveValue: { value in
            
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(requestMade)
        
        expectation = XCTestExpectation(description: "Result Expectation")
        requestMade = false
        
        let cache = ImageCacheManager.shared
        
        let image = UIImage()
        
        cache["-80"] = image
        
        publisher = RequestManager.shared.imagePublisher(for: "-80")
        
        publisher.sink(receiveCompletion: { completion in
            requestMade = true
            
            expectation.fulfill()
        }, receiveValue: { value in
            XCTAssertEqual(value, image)
        }).store(in: &cancellable)
        
        wait(for: [expectation], timeout: 5)
        
        XCTAssertTrue(requestMade)
    }

}
