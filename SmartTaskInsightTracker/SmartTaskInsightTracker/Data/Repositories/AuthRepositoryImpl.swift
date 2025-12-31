//
//  AuthRepositoryImpl.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

final class AuthRepositoryImpl: AuthRepository {

    private let sessionStore: SessionStore

    init(sessionStore: SessionStore) {
        self.sessionStore = sessionStore
    }

    func saveUserID(_ id: Int) {
        sessionStore.save(userID: id)
    }

    func getUserID() -> Int? {
        sessionStore.getUserID()
    }

    func logout() {
        sessionStore.clear()
    }
}
