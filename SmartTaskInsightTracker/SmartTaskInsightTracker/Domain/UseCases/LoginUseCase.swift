//
//  LoginUseCase.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

protocol LoginUseCase {
    func execute(with email: String) async throws
}

final class LoginUseCaseImpl: LoginUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute(with email: String) async throws {
        try await authRepository.login(with: email)
    }
}

