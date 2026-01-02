//
//  TodosViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

enum TodoFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case completed = "Completed"
    case pending = "Pending"
    
    var id: String { rawValue }
}

final class TodosViewModel: ObservableObject {
    
    @Published var todos: [Todo]?
    @Published var state: ViewState = .idle
    
    private let fetchTodosUseCase: TodosUseCase
    
    init(fetchTodosUseCase: TodosUseCase) {
        self.fetchTodosUseCase = fetchTodosUseCase
    }
    
    @Published var selectedFilter: TodoFilter = .all
    
    var filteredTodos: [Todo]? {
        switch selectedFilter {
        case .all:
            return todos
        case .completed:
            return todos?.filter { $0.isCompleted }
        case .pending:
            return todos?.filter { !$0.isCompleted }
        }
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
