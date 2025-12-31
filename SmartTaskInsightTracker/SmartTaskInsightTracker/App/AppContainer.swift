//
//  AppContainer.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

final class AppContainer {
    
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
            baseURL: baseURL
        )
    }()
    
    // MARK: - Session
    lazy var sessionStore: SessionStore = {
        SessionStore()
    }()
    
    // MARK: - Repositories
    lazy var authRepository: AuthRepository = {
        AuthRepositoryImpl(sessionStore: sessionStore)
    }()
    
    lazy var userRepository: UserRepository = {
        UserRepositoryImpl(
            apiClient: apiClient,
            container: self
        )
    }()
    
    // MARK: - UseCases
    lazy var loginUseCase: LoginUseCase = {
        LoginUseCase(authRepository: authRepository)
    }()
    
    lazy var logoutUseCase: LogoutUseCase = {
        LogoutUseCase(authRepository: authRepository)
    }()
    
    lazy var getSavedUserUseCase: GetSavedUserUseCase = {
        GetSavedUserUseCase(authRepository: authRepository)
    }()
    
    lazy var fetchUsersUseCase: FetchUsersUseCase = {
        FetchUsersUseCaseImpl(userRepository: userRepository)
    }()
    
    // MARK: - ViewModels
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: loginUseCase,
            getSavedUserUseCase: getSavedUserUseCase
        )
    }
    
    func makeUsersListViewModel() -> UsersListViewModel {
        UsersListViewModel(fetchUsersUseCase: fetchUsersUseCase)
    }
    
    func makeTodosViewModel() -> TodosViewModel {
        TodosViewModel()
    }

    func makePostsViewModel() -> PostsViewModel {
        PostsViewModel()
    }

    func makeAlbumsViewModel() -> AlbumsViewModel {
        AlbumsViewModel()
    }

    func makeProfileViewModel() -> ProfileViewModel {
        ProfileViewModel()
    }
}
