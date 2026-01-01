//
//  AuthRepositoryImpl.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

enum AuthError: Error {
    
    case noDataFound
    
    var errorDescription: String? {
        switch self {
        case .noDataFound:
            return "No user found against the email"
        }
    }
}

final class AuthRepositoryImpl: AuthRepository {

    private let sessionStore: SessionStoreProtocol
    private let container: AppContainer
    private let apiClient: APIClient

    init(apiClient: APIClient, sessionStore: SessionStoreProtocol, container: AppContainer) {
        self.apiClient = apiClient
        self.sessionStore = sessionStore
        self.container = container
    }

    func login(with email: String) async throws {
        do {
            let headers: [String: String]? = await {
                guard
                    let userID = try? await container.sessionStore.getUserID(),
                    let authHeader = APIConfig.Headers.authorization(with: String(userID))
                else {
                    return nil
                }
                
                return ["Authorization": authHeader]
            }()
            
            let request = DynamicAPIRequest<[UserDTO]>(
                path: .users,
                method: .get,
                queryParameters: [APIConfig.Queries.email(email)],
                headers: headers,
            )
            
            if let userData = try await apiClient.request(request).first {
                try await sessionStore.save(user: userData.toEntity())
            } else {
                throw AuthError.noDataFound
            }
        } catch {
            throw error
        }
    }

    func logout() async throws {
        try await sessionStore.clear()
    }

    func getSavedUser() async throws -> User {
        try await sessionStore.getUser()
    }
}
