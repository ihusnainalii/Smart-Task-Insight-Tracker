//
//  Untitled.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct LoginView: View {
    
    @Environment(\.appContainer) private var container
    @StateObject private var viewModel: LoginViewModel
    @State private var showUsers = false
    @State private var errorMessage: String? = nil
    @Binding var isLoggedIn: Bool
    
    init(viewModel: LoginViewModel, isLoggedIn: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isLoggedIn = isLoggedIn
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
            VStack(alignment: .leading) {
                Text("Sign in to your\nAccount")
                    .font(of: .poppinsBold32, with: .neutralDark)
                
                Text("Enter user email for which you need to use app...")
                    .font(of: .poppinsRegular12, with: .neutralDark)
            }
            
            Spacer()
            
            CustomTextField(
                title: "Email Address",
                placeholder: "Enter email Address...",
                placeholderColor: .brand,
                text: $viewModel.email,
                errorMessage: errorMessage
            )
            
            HStack {
                Spacer()
                
                Button {
                    showUsers = true
                } label: {
                    Text("View Available Users")
                }
                .buttonStyle(.ghost)
            }
            
            Button {
                showUsers = false
                Task {
                    await viewModel.login()
                }
            } label: {
                Text("Login")
            }
            .buttonStyle(.primary(size: .normal))
            .disabled(!viewModel.email.isValidEmail)
            .applyIf(viewModel.state == .loading) { button in
                button.overlay {
                    ProgressView()
                }
            }
            
            Spacer()
        }
        .padding()
        .navigationDestination(isPresented: $showUsers) {
            UsersListView(
                viewModel: UsersListViewModel(fetchUsersUseCase: container.fetchUsersUseCase)
            ) { selectedUserEmail in
                errorMessage = nil
                viewModel.email = "\(selectedUserEmail)"
                showUsers = false
            }
        }
        .onChange(of: viewModel.email) {
            errorMessage = viewModel.email.isValidEmail ? nil : "Enter a valid email address"
        }
        .onChange(of: viewModel.state) { _, newState in
            switch newState {
            case .error(let message):
                errorMessage = message
            case .success:
                errorMessage = nil
                isLoggedIn = true
            default:
                errorMessage = nil
            }
        }
    }
}

#Preview {
    let authRepository = AuthRepositoryImpl(apiClient: APIClient(baseURL: URL(string: "")!, logger: ConsoleNetworkLogger()),
                                            sessionStore: SessionStore(), container: AppContainer())
    LoginView(viewModel: LoginViewModel(loginUseCase: LoginUseCaseImpl(authRepository: authRepository),
                                        getSavedUserUseCase: GetSavedUserUseCaseImpl(authRepository: authRepository)),
              isLoggedIn: .constant(false))
    .loadView()
}
