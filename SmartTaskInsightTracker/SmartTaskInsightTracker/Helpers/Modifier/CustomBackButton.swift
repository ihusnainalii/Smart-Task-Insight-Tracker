//
//  CustomBackButton.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct CustomBackButton: ViewModifier {
    
    @Environment(\.dismiss) var dismiss
    var title: String?
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        if let title {
                            Text(title)
                                .font(of: .poppinsMedium14, with: .brand)
                        } else {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(alignment: .center)
                        }
                    }
                }
            }
    }
}

extension View {
    func customBackButton() -> some View {
        self.modifier(CustomBackButton())
    }
    
    func customBackButton(with title: String?) -> some View {
        self.modifier(CustomBackButton(title: title))
    }
}

