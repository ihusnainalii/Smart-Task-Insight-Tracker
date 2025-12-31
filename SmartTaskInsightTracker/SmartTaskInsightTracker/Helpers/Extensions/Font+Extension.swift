//
//  Font+Extension.swift
//  SmartTaskInsightTracker
//
//  Created by Husnain Ali - ILI on 31/12/2025.
//

import Foundation
import SwiftUI
 
/// This class adds font support for swift ui previews in swift packages.
private struct FontLoaderView<T>: View where T: View {
    
    // Content to be displayed with loaded fonts.
    private var content: T
    
    init(content: T) {
        PoppinsFonts.registerAll()
        self.content = content
    }
    
    var body: some View {
        content
    }
}
 
extension View {
    // Add this modifier to any swift ui preview in this swift ui package to load fonts.
    internal func loadView() -> some View {
        FontLoaderView(
            content: self
        )
    }
}
 
/// Registers external fonts in the application
struct FontLoader {
    static func registerFont(fileName: String) {
        guard let pathForResourceString = Bundle.main.path(forResource: fileName, ofType: nil),
              let fontData = NSData(contentsOfFile: pathForResourceString),
              let dataProvider = CGDataProvider(data: fontData),
              let fontRef = CGFont(dataProvider) else {
            print("Failed to load font: \(fileName)")
            return
        }
        
        var errorRef: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) {
            print("Failed to register font: \(fileName)")
        }
    }
}
