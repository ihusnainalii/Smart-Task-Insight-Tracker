//
//  MockUserRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

@testable import SmartTaskInsightTracker

final class MockUserRepository: UserRepository {

    func fetchUsers() async throws -> [UserEntity] {
        [
            UserEntity(
                id: 1,
                name: "Leanne Graham",
                username: "Bret",
                email: "Sincere@april.biz",
                city: "Gwenborough",
                companyName: "Romaguera-Crona"
            )
        ]
    }
}
