//
//  TodosView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct TodosView: View {
    
    @StateObject private var viewModel: TodosViewModel
    @Binding var isFilterPresented: Bool
    
    init(viewModel: TodosViewModel, isFilterPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isFilterPresented = isFilterPresented
    }
    
    var body: some View {
        VStack {
            
            if isFilterPresented {
                TodoFilterBar(selectedFilter: $viewModel.selectedFilter)
            }
            
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    Spacer()
                    ProgressView("Loading Todos...")
                        .task {
                            await viewModel.fetchTodos()
                        }
                    Spacer()
                    
                case .success:
                    if let todos = viewModel.filteredTodos {
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
        }
    }
}
