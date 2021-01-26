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
    var department: String
    var name: String
    var surname: String
    var image: String
    var title: String
    var agency: String
    var intro: String
    var description: String
    
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
