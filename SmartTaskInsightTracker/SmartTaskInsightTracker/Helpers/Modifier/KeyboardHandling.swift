//
//  KeyboardHandling.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation
import SwiftUI

struct KeyboardHandling: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}

extension View {
    func closeKeyboardWhenTap() -> some View {
        self.modifier(KeyboardHandling())
    }
}
