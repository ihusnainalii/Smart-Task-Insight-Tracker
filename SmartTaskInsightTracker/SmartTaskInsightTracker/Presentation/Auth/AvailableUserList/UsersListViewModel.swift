//
//  UsersListViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

final class UsersListViewModel: ObservableObject {

    @Published var users: [User] = []
    @Published var state: ViewState = .idle

    private let fetchUsersUseCase: FetchUsersUseCase

    init(fetchUsersUseCase: FetchUsersUseCase) {
        self.fetchUsersUseCase = fetchUsersUseCase
    }

    @MainActor
    func fetchUsers() async {
        state = .loading
        do {
            let users = try await fetchUsersUseCase.execute()
            self.users = users
            self.state = .success
        } catch {
            self.state = .error(error.localizedDescription)
        }
    }
}

