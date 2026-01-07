//
//  CreateTodoSheetViewModel.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//


import Foundation

final class CreateTodoSheetViewModel: ObservableObject {

    // MARK: - State
    @Published var title: String = ""
    @Published var state: ViewState = .idle

    // MARK: - Dependencies
    private let createTodoUseCase: TodosUseCase

    init(createTodoUseCase: TodosUseCase) {
        self.createTodoUseCase = createTodoUseCase
    }

    @MainActor
    func createTodo() async -> Todo? {
        guard !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            state = .error("Title cannot be empty")
            return nil
        }

        state = .loading

        do {
            let todo = try await createTodoUseCase.createTodo(with: title)
            state = .success
            return todo
        } catch {
            state = .error(error.localizedDescription)
            return nil
        }
    }
}
