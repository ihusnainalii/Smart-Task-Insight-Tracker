//
//  TodosView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct TodosView: View {
    
    @Environment(\.appContainer) private var container
    @StateObject private var viewModel: TodosViewModel
    @Binding var isFilterPresented: Bool
    @State private var showCreateTodo = false
    
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
                    ProgressView("Loading Todos...")
                        .task {
                            await viewModel.fetchTodos()
                        }
                    Spacer()
                case .success:
                    if let todos = viewModel.filteredTodos, !todos.isEmpty {
                        List {
                            ForEach(todos, id: \.id) { todo in
                                HStack {
                                    Button {
                                        Task {
                                            await viewModel.update(todo: todo)
                                        }
                                    } label: {
                                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                            .foregroundColor(todo.isCompleted ? .green : .gray)
                                    }
                                    
                                    Text(todo.title)
                                        .strikethrough(todo.isCompleted)
                                }
                            }
                            .onDelete(perform: deleteTodos)
                        }
                        .listStyle(.plain)
                        .refreshable {
                            // refresh data again
                        }
                    } else {
                        switch viewModel.selectedFilter {
                        case .all:
                            GenericUnavailableView(
                                title: "No Todos",
                                systemImage: "list.bullet.rectangle.fill",
                                description: "You don’t have any todos yet. Start by adding a new todo!"
                            )
                        case .completed:
                            GenericUnavailableView(
                                title: "No Completed Todos",
                                systemImage: "checkmark.circle.fill",
                                description: "You haven’t completed any todos yet."
                            )
                        case .pending:
                            GenericUnavailableView(
                                title: "No Pending Todos",
                                systemImage: "clock.fill",
                                description: "You don’t have any pending todos at the moment."
                            )
                        }
                    }
                case .error(let message):
                    Text(message)
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $showCreateTodo) {
            CreateTodoSheetView(
                viewModel: container.makeCreateTodoSheetViewModel()
            ) { newTodo in
                viewModel.addTodo(newTodo)
            }
        }
        .overlay(alignment: .top) {
            if let toast = viewModel.toast {
                ToastBannerView(toast: toast)
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: viewModel.toast)
        .overlay(alignment: .bottomTrailing) {
            FloatingActionButton(
                action: {
                    withAnimation(.spring()) {
                        showCreateTodo = true
                    }
                },
                icon: "plus"
            )
            .offset(x: -20, y: -20)
        }
    }
    
    private func deleteTodos(at offsets: IndexSet) {
        guard let filtered = viewModel.filteredTodos else { return }
        for index in offsets {
            let todoToDelete = filtered[index]
            Task {
                await viewModel.delete(todo: todoToDelete)
            }
        }
    }
}
