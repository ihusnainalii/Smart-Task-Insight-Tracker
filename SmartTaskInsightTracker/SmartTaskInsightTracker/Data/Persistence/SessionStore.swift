//
//  SessionStore.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation
import Security

final class SessionStore {

    private let service = Bundle.main.bundleIdentifier ?? "SmartTaskApp"
    private let account = "logged_in_user_id"

    // Save userID
    func save(userID: Int) {
        let data = "\(userID)".data(using: .utf8)!
        
        // Check if already exists
        if getUserID() != nil {
            update(data: data)
        } else {
            add(data: data)
        }
    }

    // Get userID
    func getUserID() -> Int? {
        guard let data = read() else { return nil }
        return Int(String(decoding: data, as: UTF8.self))
    }

    // Clear userID
    func clear() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(query as CFDictionary)
    }

    // MARK: - Private helpers
    private func add(data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]
        SecItemAdd(query as CFDictionary, nil)
    }

    private func update(data: Data) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        let attributes: [String: Any] = [
            kSecValueData as String: data
        ]
        SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
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
}
