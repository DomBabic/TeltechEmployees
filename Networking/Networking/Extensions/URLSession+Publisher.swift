//
//  URLSession+Publisher.swift
//  Networking
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation
import Combine
import UIKit

public extension URLSession {
    
    /**
        Convenience method for constructing Publisher which performs data tasks and decodes response to specified data model.
     
        - Parameters:
            - url: URL object for which data task is performed.
            - responseType: Decodable type to which response will be mapped.
            - decoder: JSONDecoder object with which decoding is performed. Default object is constructed from default initializer,
                        for custom decoding strategies customized JSONDecoder should be used.
     
        - Returns:
            AnyPublisher object which performs data task and emits Result.
     
        - Tag: genericPublisher
     */
    func publisher<T: Decodable>(for url: URL,
                                 _ responseType: T.Type = T.self,
                                 decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .tryMap() { element -> Data in
                guard let response = element.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    /**
        Convenience method for constructing Publisher which performs data tasks. Used for async loading of image data.
     
        - Parameters:
            - url: URL object for which data task is performed.
            - onReceive: Escaping closure used to handle received output events.
     
        - Returns:
            AnyPublisher object which performs data task and emits Result.
     
        - Tag: imagePublisher
     */
    func imagePublisher(for url: URL, onReceive: @escaping (UIImage?) -> ()) -> AnyPublisher<UIImage?, Error> {
        dataTaskPublisher(for: url)
            .tryMap() { element -> UIImage? in
                guard let response = element.response as? HTTPURLResponse,
                      response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                return UIImage(data: element.data)
            }
            .handleEvents(receiveOutput: {
                onReceive($0)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
