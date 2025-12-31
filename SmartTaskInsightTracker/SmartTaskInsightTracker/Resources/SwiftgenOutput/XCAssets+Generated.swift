
// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import SwiftUI

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum AssetCatalog {
  internal enum Assets {
    internal static let accentColor = ColorAsset(name: "AccentColor")
  }
  internal enum Colors {
    internal static let brand = ColorAsset(name: "brand")
    internal static let brand100 = ColorAsset(name: "brand100")
    internal static let brand200 = ColorAsset(name: "brand200")
    internal static let brand300 = ColorAsset(name: "brand300")
    internal static let brand400 = ColorAsset(name: "brand400")
    internal static let brand50 = ColorAsset(name: "brand50")
    internal static let brand500 = ColorAsset(name: "brand500")
    internal static let brand600 = ColorAsset(name: "brand600")
    internal static let brand800 = ColorAsset(name: "brand800")
    internal static let brand900 = ColorAsset(name: "brand900")
    internal static let disableField = ColorAsset(name: "disable field")
    internal static let disable = ColorAsset(name: "disable")
    internal static let fieldShadow = ColorAsset(name: "field shadow")
    internal static let neutral = ColorAsset(name: "neutral")
    internal static let neutralDark = ColorAsset(name: "neutralDark")
    internal static let neutralLight = ColorAsset(name: "neutralLight")
    internal static let neutralMediam = ColorAsset(name: "neutralMediam")
    internal static let danger = ColorAsset(name: "danger")
    internal static let info = ColorAsset(name: "info")
    internal static let success = ColorAsset(name: "success")
    internal static let warning = ColorAsset(name: "warning")
    internal static let shadow = ColorAsset(name: "shadow")
    internal static let placeholder = ColorAsset(name: "placeholder")
    internal static let textDisabled = ColorAsset(name: "textDisabled")
    internal static let textHeading = ColorAsset(name: "textHeading")
    internal static let textNonActive = ColorAsset(name: "textNonActive")
    internal static let textParagraph = ColorAsset(name: "textParagraph")
  }
  internal enum Icons {
    internal static let akarIconsShoppingBag = ImageAsset(name: "akar-icons_shopping-bag")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  let name: String

  internal var color: Color {
    Color(self)
  }
}

internal extension Color {
  /// Creates a named color.
  /// - Parameter asset: the color resource to lookup.
  init(_ asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(asset.name, bundle: bundle)
  }
}

internal struct ImageAsset {
  let name: String

  internal var image: Image {
    Image(name)
  }
}

internal extension Image {
  /// Creates a labeled image that you can use as content for controls.
  /// - Parameter asset: the image resource to lookup.
  init(_ asset: ImageAsset) {
    let bundle = Bundle(for: BundleToken.self)
    self.init(asset.name, bundle: bundle)
  }
}

private final class BundleToken {}
