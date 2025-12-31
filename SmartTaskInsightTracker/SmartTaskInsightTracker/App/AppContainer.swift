//
//  AppContainer.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation

final class AppContainer {

    // MARK: - Session & Repositories
    private lazy var sessionStore: SessionStore = {
        SessionStore()
    }()

    lazy var authRepository: AuthRepository = {
        AuthRepositoryImpl(sessionStore: sessionStore)
    }()

//    lazy var userRepository: UserRepository = {
//        UserRepositoryImpl(apiClient: apiClient)
//    }()
//
//    // MARK: - Network
//    private lazy var apiClient: APIClient = {
//        APIClient()
//    }()

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

//    lazy var fetchUsersUseCase: FetchUsersUseCase = {
//        FetchUsersUseCase(userRepository: userRepository)
//    }()

    // MARK: - ViewModels
    func makeLoginViewModel() -> LoginViewModel {
        LoginViewModel(
            loginUseCase: loginUseCase,
            getSavedUserUseCase: getSavedUserUseCase
        )
    }

//    func makeUsersListViewModel() -> UsersListViewModel {
//        UsersListViewModel(fetchUsersUseCase: fetchUsersUseCase)
//    }
//
//    func makeHomeViewModel() -> HomeViewModel {
//        HomeViewModel(logoutUseCase: logoutUseCase)
//    }
}
