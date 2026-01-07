//
//  AuthRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

protocol AuthRepository {
    func login(with email: String) async throws
    func logout() async throws
    func getSavedUser() async throws -> User
}
