//
//  AppContainer.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

final class AppContainer {
    
    private var networkLogger: NetworkLogger {
        #if DEBUG
        ConsoleNetworkLogger()
        #endif
    }
    
    // MARK: - Network
    private var baseURL: URL {
        guard
            let baseURLString = Bundle.main.object(
                forInfoDictionaryKey: "BASE_URL"
            ) as? String,
            let url = URL(string: baseURLString)
        else {
            fatalError("❌ BASE_URL not set in xcconfig / Info.plist")
        }
        return url
    }
    
    private lazy var apiClient: APIClient = {
        APIClient(
            baseURL: baseURL,
            logger: networkLogger
        )
    }()
    
    // MARK: - Session
    lazy var sessionStore: SessionStoreProtocol = {
        SessionStore()
    }()
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepository = {
        AuthRepositoryImpl(
            apiClient: apiClient,
            sessionStore: sessionStore,
            container: self
        )
    }()
    
    lazy var userRepository: UserRepository = {
        UserRepositoryImpl(
            apiClient: apiClient,
            container: self
        )
    }()
    
    lazy var todoRepository: TodoRepository = {
        TodoRepositoryImpl(
            apiClient: apiClient,
            container: self
        )
    }()
    
    // MARK: - UseCases
    lazy var loginUseCase: LoginUseCase = {
        LoginUseCaseImpl(authRepository: authRepository)
    }()
    
    lazy var logoutUseCase: LogoutUseCase = {
        LogoutUseCaseImpl(authRepository: authRepository)
    }()
    
    lazy var getSavedUserUseCase: GetSavedUserUseCase = {
        GetSavedUserUseCaseImpl(authRepository: authRepository)
    }()
    
    lazy var fetchUsersUseCase: FetchUsersUseCase = {
        FetchUsersUseCaseImpl(userRepository: userRepository)
    }()
    
    lazy var fetchTodosUseCase: TodosUseCase = {
        TodosUseCaseImpl(repository: todoRepository)
    }()
    
    // MARK: - ViewModels
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(loginUseCase: loginUseCase, getSavedUserUseCase: getSavedUserUseCase)
    }
    
    func makeUsersListViewModel() -> UsersListViewModel {
        UsersListViewModel(fetchUsersUseCase: fetchUsersUseCase)
    }
    
    func makeTodosViewModel() -> TodosViewModel {
        TodosViewModel(fetchTodosUseCase: fetchTodosUseCase)
    }
    
    func makePostsViewModel() -> PostsViewModel {
        PostsViewModel()
    }
    
    func makeAlbumsViewModel() -> AlbumsViewModel {
        AlbumsViewModel()
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel(getUserUseCase: getSavedUserUseCase)
    }
}
