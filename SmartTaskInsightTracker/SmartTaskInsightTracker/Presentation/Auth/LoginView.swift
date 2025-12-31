//
//  Untitled.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct LoginView: View {
    
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
                
                Text("Enter user id for which you need to use app...")
                    .font(of: .poppinsRegular12, with: .neutralDark)
            }
            
            Spacer()
            
            CustomTextField(
                title: "User ID",
                placeholder: "Enter User ID...",
                placeholderColor: .brand,
                text: $viewModel.userID,
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
                viewModel.login()
            } label: {
                Text("Login")
            }
            .buttonStyle(.primary(size: .normal))
            .disabled(viewModel.userID.isEmpty)
            
            Spacer()
            
            // Show error message
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
                    .onAppear {
                        errorMessage = message
                    }
            }
            
        }
        .padding()
        .navigationDestination(isPresented: $showUsers) {
            
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
    let authRepository = AuthRepositoryImpl(sessionStore: SessionStore())
    LoginView(viewModel: LoginViewModel(loginUseCase: LoginUseCase(authRepository: authRepository),
                                        getSavedUserUseCase: GetSavedUserUseCase(authRepository: authRepository)), isLoggedIn: .constant(false))
    .loadView()
}
