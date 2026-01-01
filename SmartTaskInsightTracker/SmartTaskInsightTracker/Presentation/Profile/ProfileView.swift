//
//  ProfileView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct ProfileView: View {
    
    let onLogout: () -> Void
    @StateObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel,
         onLogout: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onLogout = onLogout
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if viewModel.state == .loading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .padding()
                } else if let user = viewModel.user {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Name: \(user.name)")
                        Text("Username: \(user.username)")
                        Text("Email: \(user.email)")
                        Text("City: \(user.city)")
                        Text("Company: \(user.companyName)")
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(12)
                    .shadow(radius: 2)
                    
                    HStack(spacing: 20) {
                        Button("Edit Details") {
                            viewModel.isEditing = true
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                        Spacer()
                        Button {
                            onLogout()
                        } label: {
                            Text("Logout")
                        }
                        .buttonStyle(.primary(size: .normal))
                    }
                    .padding(.horizontal)
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .task {
                await viewModel.fetchUser()
            }
            .sheet(isPresented: $viewModel.isEditing) {
                if let user = viewModel.user {
                    EditUserView(user: user) { updatedUser in
                        viewModel.isEditing = false
                    }
                }
            }
        }
    }
}

struct EditUserView: View {
    @State var user: User
    var onSave: (User) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Details")) {
                    TextField("Name", text: $user.name)
                    TextField("Username", text: $user.username)
                    TextField("Email", text: $user.email)
                    TextField("City", text: $user.city)
                    TextField("Company", text: $user.companyName)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(user)
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
