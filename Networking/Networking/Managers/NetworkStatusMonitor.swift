//
//  NetworkStatusMonitor.swift
//  Networking
//
//  Created by Dominik Babić on 28/01/2021.
//

import Foundation
import Network

/**
    Manager class responsible for handling network status changes.
 
    It is used for displaying banner with information when device is not connected to network.
 */
public class NetworkStatusMonitor: ObservableObject {
    
    public static var shared = NetworkStatusMonitor()
    
    private let monitor = NWPathMonitor()
    private let monitoringQueue = DispatchQueue(label: "monitor", qos: DispatchQoS.background)
    
    @Published public var isOnline = true
    
    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied || path.status == .requiresConnection
            }
        }
        
        monitor.start(queue: monitoringQueue)
    }
}
