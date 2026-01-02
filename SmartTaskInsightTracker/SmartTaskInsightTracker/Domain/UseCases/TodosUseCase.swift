//
//  FetchTodosUseCase.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


protocol TodosUseCase {
    func fetchTodos() async throws -> [Todo]?
}

final class TodosUseCaseImpl: TodosUseCase {

    private let repository: TodoRepository

    init(repository: TodoRepository) {
        self.repository = repository
    }

    func fetchTodos() async throws -> [Todo]? {
        try await repository.fetchTodos()
    }
}
