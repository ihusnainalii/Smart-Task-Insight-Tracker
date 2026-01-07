//
//  GetSavedUserUseCase.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

protocol GetSavedUserUseCase {
    func execute() async throws -> User
}

final class GetSavedUserUseCaseImpl: GetSavedUserUseCase {

    private let authRepository: AuthRepository

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }

    func execute() async throws -> User {
        try await authRepository.getSavedUser()
    }
}

