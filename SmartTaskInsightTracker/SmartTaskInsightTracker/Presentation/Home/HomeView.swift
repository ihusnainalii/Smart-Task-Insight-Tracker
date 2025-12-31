//
//  HomeView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct HomeView: View {

    let userID: Int?
    let onLogout: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Welcome!")
                    .font(.largeTitle.bold())

                if let id = userID {
                    Text("Logged in as User ID: \(id)")
                        .font(.title3)
                        .foregroundColor(.secondary)
                } else {
                    Text("User not found")
                        .foregroundColor(.red)
                }
                
                Button {
                    onLogout()
                } label: {
                    Text("Logout")
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding()
            .navigationTitle("Home")
        }
    }
}
