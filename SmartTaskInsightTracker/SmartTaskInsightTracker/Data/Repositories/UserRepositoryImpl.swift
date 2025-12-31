//
//  UserRepositoryImpl.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//


import Foundation

final class UserRepositoryImpl: UserRepository {
    
    private let apiClient: APIClient
    private let container: AppContainer
    
    init(apiClient: APIClient, container: AppContainer) {
        self.apiClient = apiClient
        self.container = container
    }
    
    func fetchUsers() async throws -> [User] {
        
        let headers: [String: String]? = {
            guard
                let userID = container.sessionStore.getUserID(),
                let authHeader = APIConfig.Headers.authorization(with: String(userID))
            else {
                return nil
            }
            
            return ["Authorization": authHeader]
        }()
        
        let request = DynamicAPIRequest<[UserDTO]>(
            path: .users,
            method: .get,
            headers: headers
        )
        
        return try await apiClient.request(request).map { UserDTO in
            UserDTO.toEntity()
        }
    }
}
