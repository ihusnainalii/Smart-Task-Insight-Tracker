//
//  TodoFilterBar.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//

import SwiftUI

struct TodoFilterBar: View {

    @Binding var selectedFilter: TodoFilter

    var body: some View {
        HStack(spacing: 8) {
            ForEach(TodoFilter.allCases) { filter in
                Button {
                    withAnimation(.easeInOut) {
                        selectedFilter = filter
                    }
                } label: {
                    Text(filter.rawValue)
                        .font(.poppinsRegular12)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                        .background(
                            selectedFilter == filter
                            ? Color.brand.opacity(0.15)
                            : Color.clear
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    selectedFilter == filter
                                    ? Color.brand
                                    : Color.gray.opacity(0.3)
                                )
                        )
                        .foregroundColor(
                            selectedFilter == filter
                            ? .brand
                            : .neutralDark
                        )
                }
            }
        }
        .padding(8)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.05), radius: 4)
    }
}
