//
//  Optional+extension.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

extension Optional {
    public var isNil: Bool {
        self == nil
    }
    
    public var isNotNil: Bool {
        isNil.isFalse
    }
}
