//
//  TodosView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct TodosView: View {
    @StateObject var viewModel: TodosViewModel

    var body: some View {
        VStack {
            Text("Todos")
        }
        .navigationTitle("Todos")
    }
}
