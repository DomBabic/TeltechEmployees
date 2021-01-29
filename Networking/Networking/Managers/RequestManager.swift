//
//  RequestManager.swift
//  Networking
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation
import Combine
import UIKit

/**
    Manager class responsible for constructing data task publishers.
 
    RequestManager provides [shared](x-source-tag://shared) instance to be used when creating data task publishers.
 
    - Tag: RequestManager
 */
public class RequestManager {
    
    ///URLSession instance from which data task publishers are constructed.
    private var session = URLSession.shared
    
    /**
        Singleton instance of RequestManager class.
     
        - Tag: shared
     */
    public static var shared = RequestManager()
    
    private var imageCache = ImageCacheManager.shared
    
    /**
        Method used to construct data task publisher.
     
        Constructed publisher performs data task on [employees endpoint](x-source-tag://employeesEndpoint),
        received response is then mapped to an array of [Employee](x-source-tag://Employee) objects,
        in case of a failure an error will be thrown.
     
        - Returns:
            Publisher which expects to receive an array of Employee objects in response.
     
        - Tag: employeePublisher
     */
    public func employeePublisher() -> AnyPublisher<[Employee], Error> {
        let endpoint = Endpoint.employees()
        return publisher(for: endpoint, with: [Employee].self)
    }
    
    /**
        Method used to construct data task publisher.
     
        Constructed publisher performs data task on [image endpoint](x-source-tag://imageEndpoint),
        received response is then mapped to UIImage object and cached.
        If cache contains image for imageName key, cached object will be fetched instead.
        in case of a failure an error will be thrown.
     
        - Parameters:
            - imageName: String used to construct resource location.
     
        - Returns:
            Publisher which expects to receive a UIImage object in response.
     
        - Tag: imagePublisherForImageName
     */
    public func imagePublisher(for imageName: String) -> AnyPublisher<UIImage?, Error> {
        if let image = imageCache[imageName] {
            return AnyPublisher(Result<UIImage?, Error>.Publisher(image))
        }
        
        guard let url = Endpoint.image(with: imageName).url else {
            return AnyPublisher(Result<UIImage?, Error>.Publisher(URLError(.badURL)))
        }
        
        let publisher = session.imagePublisher(for: url, onReceive: { [weak self] in
            self?.imageCache[imageName] = $0
        })
        
        return publisher
    }
    
    /**
        Generic method used to construct Publisher based on provided Endpoint.
     
        - Parameters:
            - endpoint: Endpoint object for which [url](x-source-tag://url) data task will be executed.
            - type: Generic type which defines data model to which response will be mapped.
    
        - Returns:
            Generic which attempts to fetch data and map it to provided data model type. In case of invalid URL, returned Publisher will emit badURL error.
     */
    public func publisher<T: Decodable>(for endpoint: Endpoint, with type: T.Type = T.self) -> AnyPublisher<T, Error> {
        guard let url = endpoint.url else {
            return AnyPublisher(Result<T, Error>.Publisher(URLError(.badURL)))
        }
        
        return session.publisher(for: url, T.self)
    }
}
