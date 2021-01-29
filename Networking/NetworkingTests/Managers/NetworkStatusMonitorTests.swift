//
//  NetworkStatusMonitorTests.swift
//  NetworkingTests
//
//  Created by Dominik Babić on 29/01/2021.
//

import XCTest
import Networking

class NetworkStatusMonitorTests: XCTestCase {

    func testMonitor() {
        let networkMonitor = NetworkStatusMonitor.shared
        
        let queue = networkMonitor.monitor.queue
        
        XCTAssertNotNil(queue)
        
        XCTAssertEqual(queue?.label, "monitor")
    }

}
