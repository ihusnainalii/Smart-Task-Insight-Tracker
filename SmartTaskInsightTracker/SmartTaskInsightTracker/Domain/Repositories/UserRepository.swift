//
//  UserRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

protocol UserRepository {
    func fetchUsers() async throws -> [User]
}
