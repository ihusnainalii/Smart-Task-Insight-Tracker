//
//  TodosView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct TodosView: View {

    @StateObject private var viewModel: TodosViewModel

    init(viewModel: TodosViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Loading Todos...")
                    .task {
                        await viewModel.fetchTodos()
                    }

            case .success:
                if let todos = viewModel.todos {
                    List(todos) { todo in
                        HStack {
                            Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundColor(todo.isCompleted ? .green : .gray)

                            Text(todo.title)
                                .strikethrough(todo.isCompleted)
                        }
                    }
                    .listStyle(.plain)
                }
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Todos")
    }
}
