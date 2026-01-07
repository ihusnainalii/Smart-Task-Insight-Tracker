//
//  ProfileViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var isEditing = false
    @Published private(set) var state: ViewState = .idle
    @Published private(set) var errorMessage: String?
    
    private let getUserUseCase: GetSavedUserUseCase
    
    init(getUserUseCase: GetSavedUserUseCase) {
        self.getUserUseCase = getUserUseCase
    }
    
    @MainActor
    func fetchUser() async {
        state = .loading
        do {
            user = try await getUserUseCase.execute()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
