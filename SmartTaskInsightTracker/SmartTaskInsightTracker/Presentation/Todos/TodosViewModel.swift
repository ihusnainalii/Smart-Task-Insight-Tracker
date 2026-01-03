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
    
    @Published var todos: [Todo]? = [] {
        didSet {
            applyFilter()
        }
    }
    @Published var state: ViewState = .idle
    @Published var toast: Toast?
    @Published var selectedFilter: TodoFilter = .all {
        didSet {
            applyFilter()
        }
    }
    @Published var filteredTodos: [Todo]? = []
    
    private let todosUseCase: TodosUseCase
    
    init(todosUseCase: TodosUseCase) {
        self.todosUseCase = todosUseCase
    }
    
    private func applyFilter() {
        switch selectedFilter {
        case .all:
            filteredTodos = todos
        case .completed:
            filteredTodos = todos?.filter { $0.isCompleted }
        case .pending:
            filteredTodos = todos?.filter { !$0.isCompleted }
        }
    }
    
    @MainActor
    func addTodo(_ todo: Todo) {
        filteredTodos?.insert(todo, at: 0)
        showToast(.success, "Todos resource will not be really added on the server but it will be faked as if it is added")
    }
    
    @MainActor
    func fetchTodos() async {
        state = .loading
        do {
            todos = try await todosUseCase.fetchTodos()
            state = .success
        } catch {
            state = .error(error.localizedDescription)
            showToast(.error, error.localizedDescription)
        }
    }
    
    @MainActor
    private func showToast(_ type: ToastType, _ message: String) {
        toast = Toast(type: type, message: message)
        
        Task {
            try? await Task.sleep(for: .seconds(5))
            toast = nil
        }
    }
    
    @MainActor
    func update(todo: Todo) async {
        if todo.isCompleted {
            return
        }
        do {
            if let updatedTodo = try await todosUseCase.update(todo: todo, with: !todo.isCompleted) {
                if let index = todos?.firstIndex(where: { $0.id == updatedTodo.id }) {
                    todos?[index] = updatedTodo
                }
                state = .success
                showToast(.success, "Todos resource will not be really updated on the server but it will be faked as if it is updated")
            } else {
                state = .error("Something went wrong")
                showToast(.error, "Something went wrong")
            }
        } catch {
            showToast(.error, error.localizedDescription)
        }
    }
    
    @MainActor
    func delete(todo: Todo) async {
        do {
            try await todosUseCase.delete(todo: todo)
            if let originalIndex = todos?.firstIndex(where: { $0.id == todo.id }) {
                todos?.remove(at: originalIndex)
            }
            state = .success
            applyFilter()
            showToast(.success, "Todos resource will not be really deleted on the server but it will be faked as if it is deleted")
        } catch {
            showToast(.error, error.localizedDescription)
        }
    }
}
