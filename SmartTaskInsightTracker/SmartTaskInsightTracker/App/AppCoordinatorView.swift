//
//  AppCoordinatorView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct AppCoordinatorView: View {

    @Environment(\.appContainer) private var container
    @StateObject private var viewModel: AppCoordinatorViewModel

    init(container: AppContainer) {
        _viewModel = StateObject(
            wrappedValue: AppCoordinatorViewModel(
                getSavedUserUseCase: container.getSavedUserUseCase,
                logoutUseCase: container.logoutUseCase
            )
        )
    }

    var body: some View {
        NavigationStack {
            content
        }
        .task {
            await viewModel.onAppear()
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state {
        case .loading, .idle:
            ProgressView()
        case .unauthenticated:
            LoginView(
                viewModel: container.makeLoginViewModel(),
                isLoggedIn: Binding(
                    get: { false },
                    set: { loggedIn in
                        if loggedIn {
                            Task { await viewModel.onAppear() }
                        }
                    }
                )
            )
        case .authenticated(_):
            HomeView {
                Task {
                    await viewModel.logout()
                }
            }
        case .error( _ ):
            Text("")
        }
    }
}

