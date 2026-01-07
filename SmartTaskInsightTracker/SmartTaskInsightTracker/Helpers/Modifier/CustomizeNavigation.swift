//
//  CustomizeNavigation.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct CustomizeNavigation: ViewModifier {
    
    var navigationTitle: String
    var enableBackButton: Bool
    var backButtonTitle: String?
    var trailingItem: AnyView?
    
    func body(
        content: Content
    ) -> some View {
        content
            .navigationTitle(
                navigationTitle
            )
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(
                .inline
            )
            .toolbarBackground(
                .visible,
                for: .navigationBar
            )
            .toolbarColorScheme(
                .light,
                for: .navigationBar
            )
            .toolbarBackground(
                .white,
                for: .navigationBar
            )
            .toolbar {
                if let trailingItem {
                    ToolbarItem(
                        placement: .topBarTrailing
                    ) {
                        trailingItem
                    }
                }
            }
            .applyIf(
                enableBackButton
            ) { view in
                view.customBackButton(with: backButtonTitle)
            }
    }
}

extension View {
    func customizeNavigation(
        with title: String,
        enableBackButton: Bool
    ) -> some View {
        self.modifier(
            CustomizeNavigation(navigationTitle: title,
                                enableBackButton: enableBackButton)
        )
    }
    
    func customizeNavigation(
        with title: String,
        enableBackButton: Bool,
        backButtonTitle: String?
    ) -> some View {
        self.modifier(
            CustomizeNavigation(navigationTitle: title,
                                enableBackButton: enableBackButton,
                                backButtonTitle: backButtonTitle)
        )
    }
    
    func customizeNavigation(
        with title: String
    ) -> some View {
        self.modifier(
            CustomizeNavigation(navigationTitle: title,
                                enableBackButton: true)
        )
    }
    
    func customizeNavigation(
        with title: String,
        enableBackButton: Bool = true,
        trailingItem: AnyView? = nil
    ) -> some View {
        self.modifier(
            CustomizeNavigation(
                navigationTitle: title,
                enableBackButton: enableBackButton,
                trailingItem: trailingItem
            )
        )
    }
}
