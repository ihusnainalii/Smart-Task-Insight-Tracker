//
//  TodoRepository.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


protocol TodoRepository {
    func fetchTodos() async throws -> [Todo]?
    func createTodo(with title: String) async throws -> Todo?
    func update(todo: Todo, with statusComplete: Bool) async throws -> Todo?
    func delete(todo: Todo) async throws
}
