//
//  Endpoint.swift
//  Networking
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation

/**
    Endpoint object is constructed using endpoint path and query items.
 
    Endpoint object provides convenient way of constructing URL pointing towards [host's](x-source-tag://host) API endpoints.
 
    See:
    - [Endpoint's url](x-source-tag://url)
 
    - Tag: Endpoint
 */
open class Endpoint {
    /**
        Returns URL scheme String.
     
        - Tag: scheme
     */
    var scheme: String {
        "https"
    }
    
    /**
        Returns host URL String.
     
        - Tag: host
     */
    var host: String {
        "teltech.co"
    }
    
    /**
        Optional URL constructed with [scheme](x-source-tag://scheme), [host](x-source-tag://host) url, endpoint [path](x-source-tag://path), and [query items](x-source-tag://queryItems).
     
        - Tag: url
     */
    open var url: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        
        return components.url
    }
    
    /**
        String defining endpoint path
     
        - Tag: path
     */
    let path: String
    
    /**
        Array of URLQueryItem elements.
     
        When constructing an Endpoint, providing query parameters or sorting will result in creation of matching URLQueryItem.
     
        - Tag: queryItems
     */
    let queryItems: [URLQueryItem]
    
    public init(path: String, queryItems: [URLQueryItem]) {
        self.path = path
        self.queryItems = queryItems
    }
}

//MARK: Endpoint convenience methods
public extension Endpoint {
    /**
        Method providing convenient way of generating Endpoint object with URL pointing to Employee list API.
     
        - Parameters:
            - query: Optional query String. Default value is nil. Defines request's query.
            - sorting: Optional String. Default value is nil. Defines sorting option for requests.
     
        - Returns:
            Endpoint object with path set to "/api" and URLQueryItem array based on parameters provided.
     
        - Tag: employeesEndpoint
     */
    static func employees(query: (key: String, value: String)? = nil,
                          sortedBy sorting: String? = nil) -> Endpoint {
        
        var queryItems: [URLQueryItem] = []
        
        if let query = query {
            queryItems.append(URLQueryItem(name: query.key, value: query.value))
        }
        
        if let sorting = sorting {
            queryItems.append(URLQueryItem(name: "sort", value: sorting))
        }
        
        return Endpoint(path: "/api", queryItems: queryItems)
    }
    
    /**
        Method providing convenient way of generating Endpoint object with URL pointing to images/members endpoint.
     
        - Parameters:
            - name: String. Defines resource name to be joined with postfix -main.jpg.
     
        - Returns:
            Endpoint object with path set to "/images/members/{name}-main.jpg".
     
        - Tag: imageEndpoint
     */
    static func image(with name: String) -> Endpoint {
        return Endpoint(path: "/images/members/\(name)-main.jpg", queryItems: [])
    }
}
