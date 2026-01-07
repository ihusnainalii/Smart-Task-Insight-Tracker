//
//  Bool+Extension.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

extension Bool {
    public var isTrue: Bool {
        self
    }
    
    public var isFalse: Bool {
        self == false
    }
}
 
extension Optional where Wrapped == Bool {
    public var orTrue: Bool {
        self ?? true
    }
    
    public var orFalse: Bool {
        self ?? false
    }
}
