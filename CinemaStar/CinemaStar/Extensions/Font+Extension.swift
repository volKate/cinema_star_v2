// Font+Extension.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Расширение для шрифта Inter
extension SwiftUI.Font {
    /// Шрифт inter с жирностью 400
    /// - Parameter ofSize: размер шрифта
    /// - Returns: опциональный шрифт inter
    static func inter(ofSize size: CGFloat) -> SwiftUI.Font? {
        SwiftUI.Font.custom(FontFamily.Inter.regular, size: size)
    }

    /// Шрифт inter с жирностью 600
    /// - Parameter ofSize: размер шрифта
    /// - Returns: опциональный жирный шрифт inter
    static func interBold(ofSize size: CGFloat) -> SwiftUI.Font? {
        SwiftUI.Font.custom(FontFamily.Inter.semiBold, size: size)
    }

    /// Шрифт inter с жирностью 900
    /// - Parameter ofSize: размер шрифта
    /// - Returns: опциональный жирный шрифт inter
    static func interBlack(ofSize size: CGFloat) -> SwiftUI.Font? {
        SwiftUI.Font.custom(FontFamily.Inter.black, size: size)
    }
}
