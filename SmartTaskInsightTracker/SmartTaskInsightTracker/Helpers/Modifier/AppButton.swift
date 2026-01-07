//
//  AppButton.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import SwiftUI

enum AppButtonSize {
    case normal
    case small
}

protocol AppButtonStyle {
    var foregroundColor: Color { get }
    var background: Color { get }
    var borderColor: Color { get }
    var height: CGFloat? { get }
}

struct PrimaryPrimaryButtonStyle: AppButtonStyle {
    let size: AppButtonSize
    let foregroundColor: Color = .neutralLight
    let background: Color = .brand
    let borderColor: Color = .clear
    var height: CGFloat? {
        switch size {
            case .normal:
                return 48
            case .small:
                return 36
        }
    }
}

struct SecondaryPrimaryButtonStyle: AppButtonStyle {
    let size: AppButtonSize
    let foregroundColor: Color = .textHeading
    let background: Color = .neutralLight
    let borderColor: Color = .brand
    var height: CGFloat? {
        switch size {
            case .normal:
                return 48
            case .small:
                return 36
        }
    }
}

struct GhostPrimaryButtonStyle: AppButtonStyle {
    let foregroundColor: Color = .textHeading
    let background: Color = .clear
    let borderColor: Color = .clear
    let height: CGFloat? = nil
}

struct InfoPrimaryButtonStyle: AppButtonStyle {
    let foregroundColor: Color = .info
    let background: Color = .clear
    let borderColor: Color = .clear
    let height: CGFloat? = nil
}

struct AppButton<Style: AppButtonStyle>: ButtonStyle {
    
    let style: Style
    
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .frame(height: style.height)
            .font(.poppinsMedium14)
            .applyIf(style.height != nil) {
                $0
                    .frame(maxWidth: .infinity)
                    .background(backgroundColor(configuration))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(lineWidth: 1)
                            .fill(style.borderColor)
                    }
            }
    }
    
    func backgroundColor(_ configuration: Configuration) -> Color {
        if configuration.isPressed {
            return .textDisabled
        }
        
        if !isEnabled {
            return .textDisabled
        }
        
        return style.background
    }
    
    func foregroundColor(_ configuration: Configuration) -> Color {
        if configuration.isPressed {
            return .textNonActive
        }
        
        if !isEnabled {
            return style.foregroundColor
        }
        
        return style.foregroundColor
    }
}

extension ButtonStyle where Self == AppButton<PrimaryPrimaryButtonStyle> {
    static func primary(size: AppButtonSize = .normal) -> Self {
        AppButton(style: PrimaryPrimaryButtonStyle(size: size))
    }
}

extension ButtonStyle where Self == AppButton<SecondaryPrimaryButtonStyle> {
    static func secondary(size: AppButtonSize = .normal) -> Self {
        AppButton(style: SecondaryPrimaryButtonStyle(size: size))
    }
}

extension ButtonStyle where Self == AppButton<GhostPrimaryButtonStyle> {
    static var ghost: Self {
        AppButton(style: GhostPrimaryButtonStyle())
    }
}

extension ButtonStyle where Self == AppButton<InfoPrimaryButtonStyle> {
    static var info: Self {
        AppButton(style: InfoPrimaryButtonStyle())
    }
}
