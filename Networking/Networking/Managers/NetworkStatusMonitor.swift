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
    
    ///Singleton instance of NetworkStatusMonitor.
    public static var shared = NetworkStatusMonitor()
    
    ///NWPathMonitor which monitors changes to the network status.
    public let monitor = NWPathMonitor()
    
    ///DispatchQueue on which monitoring is performed.
    private let monitoringQueue = DispatchQueue(label: "monitor", qos: DispatchQoS.background)
    
    ///Boolean indicating whether or not network connection is established.
    @Published public var isOnline = true
    
    init() {
        monitor.pathUpdateHandler = { [unowned self] path in
            DispatchQueue.main.async {
                self.isOnline = path.status == .satisfied
            }
        }
        
        monitor.start(queue: monitoringQueue)
    }
}
