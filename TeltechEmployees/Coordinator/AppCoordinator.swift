//
//  AppCoordinator.swift
//  TeltechEmployees
//
//  Created by Dominik Babić on 28/01/2021.
//

import Foundation
import SwiftUI
import Networking
import Analytics

class AppCoordinator: ObservableObject {
    
    static var shared = AppCoordinator()
    
    @Published var entryPoint: EntryPoint = EntryPoint.ftue(route: .login)
    
    @ViewBuilder
    func scene(for entryPoint: EntryPoint) -> some View {
        switch entryPoint {
        case .ftue(let route):
            unknownUserScene(for: route)
        case .home(let route):
            knownUserScene(for: route)
        }
    }
    
    @ViewBuilder
    private func unknownUserScene(for route: UnknownUserRoutes) -> some View {
        //Switch on route and return approriate View
        LoginView()
    }
    
    @ViewBuilder
    private func knownUserScene(for route: KnownUserRoutes) -> some View {
        switch route {
        case .root:
            HomeView()
        case .detail(let employee):
            EmployeeDetailView(with: employee)
        }
    }
    
    func loginUser() {
        EventTracker.shared.trackEvent("login")
        
        entryPoint = EntryPoint.home(route: .root)
    }
    
}

/*
 Example:
 App can define different entry points. App could have been launched by a new user or already logged in user.
 These entry points can be used to setup initial app scenes based on information available (or unavailable) on user.
 */
enum EntryPoint {
    case ftue(route: UnknownUserRoutes)
    case home(route: KnownUserRoutes)
}

/*
 Example:
 Existing user is logged into the app. On app launch user would land on 'Home' view, from there user might choose
 to navigate to a history view displaying some historic data, perhaps they want to navigate to profile section.
 Deeplinking into the app might cause user to hand on something other than home.
 */
enum KnownUserRoutes {
    case root
    case detail(employee: Employee)
}

/*
 Example:
 On new app install users would probably land on a view designed with First Time User Experience in mind.
 This view might contain some descriptive informations on the app.
 From here users would be given an option to navigate to login or signup flow.
 In case of a marketing campaign, app might implement a deeplink which would navigate users to signup,
 in some cases account might be provided for user and deeplink would cause them to be taken to login.
 */
enum UnknownUserRoutes {
    case root
    case login
    case signup
}
