//
//  EmployeeCardViewModel.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 26/01/2021.
//

import Foundation
import Networking
import SwiftUI

class EmployeeCardViewModel: ObservableObject {
    
    var employee: Employee
    
    @Published var name: String = ""
    @Published var title: String = ""
    @Published var intro: String = ""
    @Published var description: String = ""
    
    init(with employee: Employee) {
        self.employee = employee
        
        name = employee.name + " " + employee.surname
        title = employee.title
        intro = employee.intro
        description = employee.description
    }
}
