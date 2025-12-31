//
//  AuthRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

protocol AuthRepository {
    func saveUserID(_ id: Int)
    func getUserID() -> Int?
    func logout()
}
