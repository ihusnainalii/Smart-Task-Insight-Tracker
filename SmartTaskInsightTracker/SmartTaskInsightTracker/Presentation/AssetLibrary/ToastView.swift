//
//  ToastView.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 03/01/2026.
//

import SwiftUI

enum ToastType {
    case success
    case error
    case warning

    var backgroundColor: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .warning: return .orange
        }
    }

    var icon: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.octagon.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }
}

struct Toast: Identifiable, Equatable {
    let id = UUID()
    let type: ToastType
    let message: String
}

struct ToastBannerView: View {

    let toast: Toast

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: toast.type.icon)
                .foregroundColor(.white)
                .font(.title3)

            Text(toast.message)
                .font(of: .poppinsMedium14, with: .white)
                .multilineTextAlignment(.leading)

            Spacer()
        }
        .padding(12)
        .frame(maxWidth: .infinity)
        .background(toast.type.backgroundColor)
        .cornerRadius(8)
        .padding(.horizontal, 8)
        .shadow(radius: 4)
    }
}


#Preview {
    VStack {
        ToastBannerView(toast: Toast(type: .success, message: "Testing sucess message \n multiliner \n multiliner \n multiliner \n multiliner"))
        ToastBannerView(toast: Toast(type: .error, message: "Testing error message \n multiliner"))
        ToastBannerView(toast: Toast(type: .warning, message: "Testing warning message \n multiliner"))
    }
}
