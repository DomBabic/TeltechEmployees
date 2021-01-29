//
//  EndpointTests.swift
//  NetworkingTests
//
//  Created by Dominik Babić on 26/01/2021.
//

import XCTest
import Networking

class EndpointTests: XCTestCase {
    
    let baseUrl = "https://teltech.co"

    func testUrl() {
        var endpoint = Endpoint(path: "/api",
                                queryItems: [ URLQueryItem(name: "name", value: "Matt")])
        
        var url = endpoint.url
        
        XCTAssertNotNil(url)
        
        XCTAssertEqual(url?.absoluteString, baseUrl + "/api?name=Matt")
        
        endpoint = Endpoint(path: "/some_path", queryItems: [])
        
        url = endpoint.url
        
        XCTAssertNotNil(url)
        
        XCTAssertEqual(url?.absoluteString, baseUrl + "/some_path")
    }
    
    func testEmployees() {
        var endpoint = Endpoint.employees()
        
        var url = endpoint.url
        
        XCTAssertNotNil(url)
        
        XCTAssertEqual(url?.absoluteString, baseUrl + "/api")
        
        endpoint = Endpoint.employees(query: (key: "name", value: "Matt"), sortedBy: "name")
        
        url = endpoint.url
        
        XCTAssertNotNil(url)
        
        XCTAssertEqual(url?.absoluteString, baseUrl + "/api?name=Matt&sort=name")
    }
    
    func testImageWithName() {
        let endpoint = Endpoint.image(with: "matt")
        
        let url = endpoint.url
        
        XCTAssertNotNil(url)
        
        XCTAssertEqual(url?.absoluteString, baseUrl + "/images/members/matt-main.jpg")
    }

}
