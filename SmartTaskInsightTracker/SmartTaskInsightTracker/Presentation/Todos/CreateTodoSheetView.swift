//
//  CreateTodoSheetView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//


import SwiftUI

struct CreateTodoSheetView: View {

    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: CreateTodoSheetViewModel
    let onCreated: (Todo) -> Void

    init(
        viewModel: CreateTodoSheetViewModel,
        onCreated: @escaping (Todo) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onCreated = onCreated
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                CustomTextField(
                    title: "Title",
                    placeholder: "Enter todo title...",
                    placeholderColor: .brand,
                    text: $viewModel.title,
                    errorMessage: viewModel.state.errorMessage
                )

                Button {
                    Task {
                        if let todo = await viewModel.createTodo() {
                            onCreated(todo)
                            dismiss()
                        }
                    }
                } label: {
                    if viewModel.state.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Create")
                            .frame(maxWidth: .infinity)
                    }
                }
                .buttonStyle(.primary(size: .normal))
                .disabled(viewModel.title.isEmpty)

                Spacer()
            }
            .padding()
            .customizeNavigation(with: "New Todo", enableBackButton: true, backButtonTitle: "Cancel")
        }
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.hidden)
    }
}
