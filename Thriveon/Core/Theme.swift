//
//  Theme.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct Theme {
    // MARK: - Colors
    static let background = Color("BackgroundColor")
    static let accent = Color("AccentColor")
    static let cardBackground = Color("CardBackground")
    static let textPrimary = Color("TextPrimary")
    static let textSecondary = Color("TextSecondary")
    static let success = Color("SuccessColor")
    static let warning = Color("WarningColor")
    
    // MARK: - Spacing
    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 12
    static let spacingL: CGFloat = 16
    static let spacingXL: CGFloat = 24
    static let spacingXXL: CGFloat = 32
    
    // MARK: - Corner Radius
    static let cornerRadiusS: CGFloat = 8
    static let cornerRadiusM: CGFloat = 12
    static let cornerRadiusL: CGFloat = 16
    static let cornerRadiusXL: CGFloat = 24
    
    // MARK: - Fonts
    static func largeTitle() -> Font {
        .system(size: 34, weight: .bold, design: .rounded)
    }
    
    static func title() -> Font {
        .system(size: 28, weight: .bold, design: .rounded)
    }
    
    static func title2() -> Font {
        .system(size: 22, weight: .semibold, design: .rounded)
    }
    
    static func headline() -> Font {
        .system(size: 17, weight: .semibold, design: .rounded)
    }
    
    static func body() -> Font {
        .system(size: 17, weight: .regular, design: .default)
    }
    
    static func callout() -> Font {
        .system(size: 16, weight: .regular, design: .default)
    }
    
    static func subheadline() -> Font {
        .system(size: 15, weight: .regular, design: .default)
    }
    
    static func caption() -> Font {
        .system(size: 12, weight: .regular, design: .default)
    }
}
