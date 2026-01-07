//
//  LoginViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

final class LoginViewModel: ObservableObject {
    
    // MARK: - Input
    @Published var email: String = ""
    
    // MARK: - Output
    @Published private(set) var state: ViewState = .idle
    
    // MARK: - Dependencies
    private let loginUseCase: LoginUseCase
    private let getSavedUserUseCase: GetSavedUserUseCase
    
    init(loginUseCase: LoginUseCase,
         getSavedUserUseCase: GetSavedUserUseCase) {
        self.loginUseCase = loginUseCase
        self.getSavedUserUseCase = getSavedUserUseCase
    }
    
    func selectUser(email: String) {
        self.email = email
    }
    
    @MainActor
    func login() async {
        guard !email.isEmpty else {
            state = .error("Please enter a valid user email address")
            return
        }
        
        state = .loading

        do {
            try await loginUseCase.execute(with: email)
            state = .success
        } catch let error as AuthError {
            state = .error(error.errorDescription ?? "Unknown error")
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    // Check if user is already logged in
    @MainActor
    func checkSavedUser() async {
        state = .loading
        do {
            let user = try await getSavedUserUseCase.execute()
            print(user.name)
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
}
