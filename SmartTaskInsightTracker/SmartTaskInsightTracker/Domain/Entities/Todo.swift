//
//  Todo.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


struct Todo: Codable, Identifiable, Equatable {
    let id: Int
    let userID: Int
    let title: String
    let isCompleted: Bool
}
