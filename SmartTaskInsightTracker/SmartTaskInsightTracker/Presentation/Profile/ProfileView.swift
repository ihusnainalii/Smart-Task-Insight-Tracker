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
        
        VStack(spacing: 0) {
            
            headerSection
            
            Spacer()
            
            Text("Version 1.0.0")
                .font(of: .poppinsRegular12, with: .gray)
                .padding(.bottom, 5)
            
            Button {
                onLogout()
            } label: {
                Text("Logout")
            }
            .buttonStyle(.primary(size: .normal))
            .padding()
        }
        .background(
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        )
        .task {
            await viewModel.fetchUser()
        }
    }
    
    // MARK: - Header Section
    private var headerSection: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.brand,
                    Color.brand
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            // Decorative circles
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 200, height: 200)
                .offset(x: -80, y: -50)
            
            Circle()
                .fill(Color.white.opacity(0.1))
                .frame(width: 150, height: 150)
                .offset(x: 100, y: 80)
            
            VStack(spacing: 12) {
                // Profile image
                if viewModel.state == .loading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.2)
                        .frame(width: 80, height: 80)
                } else {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .applyIf(viewModel.user != nil, { view in
                            view.overlay(
                                Text(viewModel.user?.name.prefixSafe() ?? "A")
                                    .font(of: .poppinsBold32, with: .brand)
                                    .frame(width: 40, height: 40)
                            )
                        })
                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                }
                
                // User info
                if let user = viewModel.user {
                    VStack(spacing: 0) {
                        Text(user.name)
                            .font(of: .poppinsMedium20, with: .white)
                        Text(user.email)
                            .font(of: .poppinsRegular14, with: .white.opacity(0.9))
                    }
                } else if let error = viewModel.errorMessage {
                    Text(error)
                        .font(of: .poppinsRegular14, with: .white.opacity(0.9))
                }
            }
        }
        .frame(height: 280)
    }
    
    // MARK: - Menu Item
    private func menuItem(icon: String, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
                    .frame(width: 24)
                
                Text(title)
                    .font(of: .poppinsRegular14, with: .primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray.opacity(0.5))
            }
            .padding(.horizontal)
            .padding(.vertical)
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func tabBarItem(icon: String, title: String, isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isSelected ? Color(red: 0.2, green: 0.7, blue: 0.85) : .gray)
            
            Text(title)
                .font(.system(size: 11))
                .foregroundColor(isSelected ? Color(red: 0.2, green: 0.7, blue: 0.85) : .gray)
        }
        .frame(maxWidth: .infinity)
    }
}
