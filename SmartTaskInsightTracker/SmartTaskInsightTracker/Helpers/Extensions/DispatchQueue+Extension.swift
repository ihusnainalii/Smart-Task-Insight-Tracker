//
//  DispatchQueue+Extension.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

import SwiftUI

func onMainQueue(after delay: TimeInterval = 2.0, withAnimation animation: Animation? = nil, execute work: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        if let animation = animation {
            withAnimation(animation) {
                work()
            }
        } else {
            work()
        }
    }
}

