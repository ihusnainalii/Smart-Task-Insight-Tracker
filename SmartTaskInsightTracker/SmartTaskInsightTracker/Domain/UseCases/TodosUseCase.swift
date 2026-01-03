//
//  FetchTodosUseCase.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


protocol TodosUseCase {
    func fetchTodos() async throws -> [Todo]?
    func createTodo(with title: String) async throws -> Todo?
    func update(todo: Todo, with statusComplete: Bool) async throws -> Todo?
    func delete(todo: Todo) async throws
}

final class TodosUseCaseImpl: TodosUseCase {
    
    private let repository: TodoRepository

    init(repository: TodoRepository) {
        self.repository = repository
    }

    func fetchTodos() async throws -> [Todo]? {
        try await repository.fetchTodos()
    }
    
    func createTodo(with title: String) async throws -> Todo? {
        try await repository.createTodo(with: title)
    }
    
    func update(todo: Todo, with statusComplete: Bool) async throws -> Todo? {
        try await repository.update(todo: todo, with: statusComplete)
    }
    
    func delete(todo: Todo) async throws {
        try await repository.delete(todo: todo)
    }
}
