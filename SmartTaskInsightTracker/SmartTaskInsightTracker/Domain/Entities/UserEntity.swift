//
//  UserEntity.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let city: String
    let companyName: String
}
