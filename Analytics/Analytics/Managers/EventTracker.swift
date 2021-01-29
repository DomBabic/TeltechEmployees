//
//  EventTracker.swift
//  Analytics
//
//  Created by Dominik Babić on 29/01/2021.
//

import Foundation
import Firebase
import FirebaseAnalytics

public class EventTracker {
    
    public static var shared = EventTracker()
    
    private var configured = false
    
    public func configureFirebase() {
        if let bundle = Bundle(identifier: "com.HeliOs.Analytics"), let filePath = bundle.path(forResource: "GoogleService-Info", ofType: "plist") {
            if let fileOptions = FirebaseOptions(contentsOfFile: filePath) {
                FirebaseApp.configure(options: fileOptions)
                
                configured = true
            }
        }
    }
    
    public func trackEvent(_ name: String, parameters: [String: Any]? = nil) {
        if configured {
            Analytics.logEvent(name, parameters: parameters)
        }
    }
}
