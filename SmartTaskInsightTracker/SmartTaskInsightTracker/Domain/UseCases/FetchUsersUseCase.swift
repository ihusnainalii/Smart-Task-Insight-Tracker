//
//  FetchUsersUseCase.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

final class FetchUsersUseCase {
    private let userRepository: UserRepository

    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute() async throws -> [UserEntity] {
        try await userRepository.fetchUsers()
    }
}
