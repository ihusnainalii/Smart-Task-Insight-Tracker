//
//  TodoRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


protocol TodoRepository {
    func fetchTodos() async throws -> [Todo]?
}
