//
//  Employee.swift
//  Networking
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation

/**
    Struct which defines server response data model for employees.
 
    - Tag: Employee
 */
public struct Employee: Codable {
    public var department: String
    public var name: String
    public var surname: String
    public var image: String
    public var title: String
    public var agency: String
    public var intro: String
    public var description: String
    
    enum CodingKeys: CodingKey {
        case department
        case name
        case surname
        case image
        case title
        case agency
        case intro
        case description
    }
}
