//
//  ImageCacheManagerTests.swift
//  NetworkingTests
//
//  Created by Dominik Babić on 29/01/2021.
//

import XCTest
import Networking

class ImageCacheManagerTests: XCTestCase {

    func testCaching() {
        let manager = ImageCacheManager.shared
        
        let image = UIImage()
        
        manager["testA"] = image
        
        XCTAssertNotNil(manager["testA"])
        
        manager["testA"] = nil
        
        XCTAssertNil(manager["testA"])
    }

}
