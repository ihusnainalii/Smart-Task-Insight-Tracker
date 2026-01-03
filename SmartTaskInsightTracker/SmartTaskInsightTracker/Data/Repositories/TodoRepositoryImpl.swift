//
//  TodoRepositoryImpl.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//

import Foundation

struct EmptyResponse: Codable {}

final class TodoRepositoryImpl: TodoRepository {
    
    private let container: AppContainer
    private let apiClient: APIClient
    
    init(apiClient: APIClient, container: AppContainer) {
        self.apiClient = apiClient
        self.container = container
    }
    
    func fetchTodos() async throws -> [Todo]? {
        guard let userId = try? await container.sessionStore.getUserID() else {
            return nil
        }
        
        let request = DynamicAPIRequest<[TodoDTO]>(
            path: .todos(userId),
            method: .get
        )
        
        return try? await apiClient.request(request).map { $0.toEntity() }
    }
    
    func createTodo(with title: String) async throws -> Todo? {
        guard let userId = try? await container.sessionStore.getUserID() else {
            return nil
        }
        
        let body = try JSONSerialization.data(
            withJSONObject: [
                "title": title,
                "userId": userId,
                "completed": false
            ]
        )
        
        let request = DynamicAPIRequest<TodoDTO>(
            path: .createTodo,
            method: .post,
            body: body
        )
        
        return try await apiClient.request(request).toEntity()
    }
    
    func update(todo: Todo, with statusComplete: Bool) async throws -> Todo? {
        let body = try JSONSerialization.data(
            withJSONObject: [
                "completed": statusComplete
            ]
        )
        
        let request = DynamicAPIRequest<TodoDTO>(
            path: .updateDeleteTodo(todo.id),
            method: .patch,
            body: body
        )
        
        return try await apiClient.request(request).toEntity()
    }
    
    func delete(todo: Todo) async throws {
        let request = DynamicAPIRequest<EmptyResponse>(
            path: .updateDeleteTodo(todo.id),
            method: .delete,
        )
        _ = try await apiClient.request(request)
    }
}
