//
//  HomeView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct HomeView: View {
    
    let onLogout: () -> Void
    @Environment(\.appContainer) private var container
    
    var body: some View {
        TabView {
            TodosView(
                viewModel: container.makeTodosViewModel()
            )
            .tabItem {
                Label("Todos", systemImage: "checklist")
            }
            
            PostsView(
                viewModel: container.makePostsViewModel()
            )
            .tabItem {
                Label("Posts", systemImage: "doc.text")
            }
            
            AlbumsView(
                viewModel: container.makeAlbumsViewModel()
            )
            .tabItem {
                Label("Albums", systemImage: "photo.on.rectangle")
            }
            
            ProfileView(
                viewModel: container.makeProfileViewModel(),
                onLogout: onLogout
            )
            .tabItem {
                Label("Profile", systemImage: "person.circle")
            }
        }
        .tint(.brand)
    }
}
