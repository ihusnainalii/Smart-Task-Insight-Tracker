//
//  AppCoordinatorView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct AppCoordinatorView: View {

    @State private var isLoggedIn: Bool = false
    @Environment(\.appContainer) private var container

    var body: some View {
        NavigationStack {
            if isLoggedIn, let id = container.authRepository.getUserID() {
                HomeView(userID: id) {
                    container.logoutUseCase.execute()
                    isLoggedIn = false
                }
            } else {
                LoginView(
                    viewModel: container.makeLoginViewModel(),
                    isLoggedIn: $isLoggedIn
                )
            }
        }
        .onAppear {
            let savedID = container.authRepository.getUserID()
            isLoggedIn = savedID != nil
        }
    }
}

