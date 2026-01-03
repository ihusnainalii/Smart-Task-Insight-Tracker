//
//  FloatingActionButton.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//

import SwiftUI

struct FloatingActionButton: View {

    let action: () -> Void
    let icon: String

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(Color.brand)
                .clipShape(Circle())
                .shadow(radius: 6)
        }
        .accessibilityLabel("Create Todo")
    }
}
