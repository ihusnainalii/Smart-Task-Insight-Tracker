//
//  SessionStore.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation
import Security

protocol SessionStoreProtocol {
    func save(user: User) async throws
    func getUser() async throws -> User
    func getUserID() async throws -> Int
    func clear() async throws
}

enum SessionStoreError: Error {
    case encodingFailed
    case decodingFailed
    case keychainError(OSStatus)
    case noSession
}

final class SessionStore: SessionStoreProtocol {

    private let service = Bundle.main.bundleIdentifier ?? "SmartTaskApp"
    private let account = "logged_in_user"

    // MARK: - Save User
    func save(user: User) async throws {
        let data: Data
        do {
            data = try JSONEncoder().encode(user)
        } catch {
            throw SessionStoreError.encodingFailed
        }

        try await withCheckedThrowingContinuation { continuation in
            if getUserSync() != nil {
                let status = update(data: data)
                status == errSecSuccess
                    ? continuation.resume()
                    : continuation.resume(throwing: SessionStoreError.keychainError(status))
            } else {
                let status = add(data: data)
                status == errSecSuccess
                    ? continuation.resume()
                    : continuation.resume(throwing: SessionStoreError.keychainError(status))
            }
        }
    }

    // MARK: - Get User
    func getUser() async throws -> User {
        try await withCheckedThrowingContinuation { continuation in
            guard let data = read() else {
                continuation.resume(throwing: SessionStoreError.noSession)
                return
            }

            do {
                let user = try JSONDecoder().decode(User.self, from: data)
                continuation.resume(returning: user)
            } catch {
                continuation.resume(throwing: SessionStoreError.decodingFailed)
            }
        }
    }

    // MARK: - Convenience
    func getUserID() async throws -> Int {
        let user = try await getUser()
        return user.id
    }

    // MARK: - Clear Session
    func clear() async throws {
        try await withCheckedThrowingContinuation { continuation in
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: account
            ]

            let status = SecItemDelete(query as CFDictionary)
            status == errSecSuccess || status == errSecItemNotFound
                ? continuation.resume()
                : continuation.resume(throwing: SessionStoreError.keychainError(status))
        }
    }

    // MARK: - Sync helpers (Keychain)
    private func add(data: Data) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        return SecItemAdd(query as CFDictionary, nil)
    }

    private func update(data: Data) -> OSStatus {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        return SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
    }

    private func read() -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }

    private func getUserSync() -> User? {
        guard let data = read() else { return nil }
        return try? JSONDecoder().decode(User.self, from: data)
    }
}
