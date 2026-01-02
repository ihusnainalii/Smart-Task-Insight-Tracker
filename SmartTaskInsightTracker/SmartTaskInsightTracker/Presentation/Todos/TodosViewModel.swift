//
//  TodosViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

final class TodosViewModel: ObservableObject {

    @Published var todos: [Todo]?
    @Published var state: ViewState = .idle

    private let fetchTodosUseCase: TodosUseCase

    init(fetchTodosUseCase: TodosUseCase) {
        self.fetchTodosUseCase = fetchTodosUseCase
    }

    @MainActor
    func fetchTodos() async {
        state = .loading
        do {
            todos = try await fetchTodosUseCase.fetchTodos()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
        }
    }
}
