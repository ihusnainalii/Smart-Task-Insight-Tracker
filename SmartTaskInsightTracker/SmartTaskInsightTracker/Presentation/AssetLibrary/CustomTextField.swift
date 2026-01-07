//
//  CustomTextField.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

struct CustomTextField: View {

    var title: String? = nil
    var titleFont: Font = .poppinsMedium14
    var titleFontColor: Color = .brand

    let placeholder: String
    var placeholderColor: Color = .gray
    var borderActiveColor: Color = .brand

    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var onCommit: (() -> Void)? = nil
    var errorMessage: String? = nil

    // Focus state
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            // Title
            if let title = title, !title.isEmpty {
                Text(title)
                    .font(of: titleFont, with: titleFontColor)
            }

            // Custom placeholder TextField
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(placeholderColor)
                        .font(.poppinsRegular12)
                        .padding()
                }

                TextField("", text: $text, onCommit: {
                    onCommit?()
                })
                .keyboardType(keyboardType)
                .padding()
                .focused($isFocused)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .tint(titleFontColor)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(borderColor, lineWidth: 1.5)
            )

            // Error message
            if let error = errorMessage, !error.isEmpty {
                Text(error)
                    .font(.poppinsRegular12)
                    .foregroundColor(.red)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isFocused)
    }

    // MARK: - Border color logic
    private var borderColor: Color {
        if let error = errorMessage, !error.isEmpty {
            return .red
        } else if isFocused {
            return borderActiveColor
        } else {
            return borderActiveColor.opacity(0.5)
        }
    }
}

#Preview {
    CustomTextField(
        title: "User ID",
        placeholder: "Enter User ID",
        placeholderColor: .red,
        text: .constant(""),
        errorMessage: "Invalid User ID"
    ).loadView()
}

