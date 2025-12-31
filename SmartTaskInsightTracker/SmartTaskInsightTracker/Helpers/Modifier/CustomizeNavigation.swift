//
//  CustomizeNavigation.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct CustomizeNavigation: ViewModifier {
    
    var navigationTitle: String
    
    func body(content: Content) -> some View {
        content
            .navigationTitle(navigationTitle)
            .navigationBarBackButtonHidden()
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
            .customBackButton()
    }
}

extension View {
    func customizeNavigation(with title: String) -> some View {
        self.modifier(CustomizeNavigation(navigationTitle: title))
    }
}
