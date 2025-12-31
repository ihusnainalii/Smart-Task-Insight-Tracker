//
//  PostsView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct PostsView: View {
    @StateObject var viewModel: PostsViewModel

    var body: some View {
        NavigationStack {
            Text("Posts")
                .navigationTitle("Posts")
        }
    }
}
