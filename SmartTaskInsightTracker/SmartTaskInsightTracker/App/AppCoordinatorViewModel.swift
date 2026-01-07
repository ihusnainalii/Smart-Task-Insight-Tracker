//
//  AppCoordinatorViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 01/01/2026.
//

import SwiftUI

enum AuthViewState: Equatable {
    case idle
    case loading
    case error(String)
    case unauthenticated
    case authenticated(User)
}

@MainActor
final class AppCoordinatorViewModel: ObservableObject {

    @Published private(set) var state: AuthViewState = .idle

    private let getSavedUserUseCase: GetSavedUserUseCase
    private let logoutUseCase: LogoutUseCase

    init(
        getSavedUserUseCase: GetSavedUserUseCase,
        logoutUseCase: LogoutUseCase
    ) {
        self.getSavedUserUseCase = getSavedUserUseCase
        self.logoutUseCase = logoutUseCase
    }

    func onAppear() async {
        state = .loading
        do {
            let user = try await getSavedUserUseCase.execute()
            state = .authenticated(user)
        } catch {
            state = .unauthenticated
        }
    }

    func logout() async {
        state = .loading
        do {
            try await logoutUseCase.execute()
            state = .unauthenticated
        } catch {
            print(error.localizedDescription)
            state = .error(error.localizedDescription)
        }
    }
}
