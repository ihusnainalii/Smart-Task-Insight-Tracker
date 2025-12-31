//
//  LoginViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

final class LoginViewModel: ObservableObject {

    // MARK: - Input
    @Published var userID: String = ""

    // MARK: - Output
    @Published var state: ViewState = .idle

    // MARK: - Dependencies
    private let loginUseCase: LoginUseCase
    private let getSavedUserUseCase: GetSavedUserUseCase

    init(loginUseCase: LoginUseCase,
         getSavedUserUseCase: GetSavedUserUseCase) {
        self.loginUseCase = loginUseCase
        self.getSavedUserUseCase = getSavedUserUseCase
    }

    // MARK: - Actions
    func login() {
        guard let id = Int(userID) else {
            state = .error("Please enter a valid user ID")
            return
        }

        state = .loading

        // Save user ID
        loginUseCase.execute(userID: id)

        // Update state to success
        state = .success
    }

    // Check if user is already logged in
    func checkSavedUser() -> Int? {
        getSavedUserUseCase.execute()
    }
}
