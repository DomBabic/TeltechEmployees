//
//  ImageCacheManager.swift
//  Networking
//
//  Created by Dominik Babić on 29/01/2021.
//

import Foundation
import UIKit

public class ImageCacheManager {
    
    public static var shared = ImageCacheManager()
    
    private var cache = NSCache<NSString, UIImage>()
    
    public subscript(key: String) -> UIImage? {
        get {
            cache.object(forKey: key as NSString)
        }
        set(image) {
            if let image = image {
                self.cache.setObject(image, forKey: key as NSString)
            } else {
                self.cache.removeObject(forKey: key as NSString)
            }
        }
    }
}
