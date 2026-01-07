//
//  EditUserView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 02/01/2026.
//

import SwiftUI

struct EditUserView: View {
    @State var user: User
    var onSave: (User) -> Void
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
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
