//
//  HomeView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

enum HomeTab: Hashable {
    case todos
    case posts
    case albums
    case profile
    
    var title: String {
        switch self {
        case .todos: return "Todos"
        case .posts: return "Posts"
        case .albums: return "Albums"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .todos: return "checklist"
        case .posts: return "doc.text"
        case .albums: return "photo.on.rectangle"
        case .profile: return "person.circle"
        }
    }
}

struct HomeView: View {
    
    let onLogout: () -> Void
    @Environment(\.appContainer) private var container
    @State var isFilterPresented = true
    
    @State private var selectedTab: HomeTab = .todos
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                
                TodosView(
                    viewModel: container.makeTodosViewModel(),
                    isFilterPresented: $isFilterPresented
                )
                .tag(HomeTab.todos)
                .tabItem {
                    Label(HomeTab.todos.title, systemImage: HomeTab.todos.icon)
                }
                
                PostsView(
                    viewModel: container.makePostsViewModel()
                )
                .tag(HomeTab.posts)
                .tabItem {
                    Label(HomeTab.posts.title, systemImage: HomeTab.posts.icon)
                }
                
                AlbumsView(
                    viewModel: container.makeAlbumsViewModel()
                )
                .tag(HomeTab.albums)
                .tabItem {
                    Label(HomeTab.albums.title, systemImage: HomeTab.albums.icon)
                }
                
                ProfileView(
                    viewModel: container.makeProfileViewModel(),
                    onLogout: onLogout
                )
                .tag(HomeTab.profile)
                .tabItem {
                    Label(HomeTab.profile.title, systemImage: HomeTab.profile.icon)
                }
            }
            .tint(.brand)
            .customizeNavigation(with: selectedTab.title,
                                 enableBackButton: false,
                                 trailingItem: selectedTab == .todos ? AnyView(
                                    Button {
                                        withAnimation {
                                            isFilterPresented.toggle()
                                        }
                                    } label: {
                                        Image(systemName: isFilterPresented ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
                                            .imageScale(.large)
                                            .foregroundColor(.brand900)
                                    }
                                 ) : nil
            )
        }
    }
}
