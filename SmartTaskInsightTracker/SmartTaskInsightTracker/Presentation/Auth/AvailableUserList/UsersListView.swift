//
//  UsersListView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct UsersListView: View {

    @StateObject private var viewModel: UsersListViewModel
    var onSelectUser: ((String) -> Void)?

    init(viewModel: UsersListViewModel, onSelectUser: ((String) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectUser = onSelectUser
    }

    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle, .loading:
                ProgressView("Loading available users...")
                    .task {
                        await viewModel.fetchUsers()
                    }
            case .success:
                List(viewModel.users, id: \.id) { user in
                    Button {
                        onSelectUser?(user.email)
                    } label: {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.name)
                                    .font(.poppinsBold14)
                                Text(user.email)
                                    .font(.poppinsRegular12)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("#\(user.username)")
                                .foregroundColor(.brand)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
            }
        }
        .customizeNavigation(with: "Available Users")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}
