//
//  UserEntity.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

struct User: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var city: String
    var companyName: String
}
