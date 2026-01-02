//
//  TodoRepositoryImpl.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//


final class TodoRepositoryImpl: TodoRepository {

    private let container: AppContainer
    private let apiClient: APIClient
    
    init(apiClient: APIClient, container: AppContainer) {
        self.apiClient = apiClient
        self.container = container
    }

    func fetchTodos() async throws -> [Todo]? {
        guard let userID = try? await container.sessionStore.getUserID() else {
            return nil
        }
        
        let request = DynamicAPIRequest<[TodoDTO]>(
            path: .todos,
            method: .get,
            queryParameters: [
                APIConfig.Queries.userId("\(userID)")
            ]
        )
        
        return try? await apiClient.request(request).map { $0.toEntity() }
    }
}
