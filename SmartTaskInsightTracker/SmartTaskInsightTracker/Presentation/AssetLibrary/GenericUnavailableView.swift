//
//  GenericUnavailableView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//


import SwiftUI

struct GenericUnavailableView: View {
    
    var title: String
    var systemImage: String
    var description: String
    
    var body: some View {
        ContentUnavailableView(
            title,
            systemImage: systemImage,
            description: Text(description)
        )
    }
}

#Preview {
    GenericUnavailableView(
        title: "Sample Title",
        systemImage: "exclamationmark.triangle",
        description: "This is a sample description."
    )
}
