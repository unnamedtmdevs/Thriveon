//
//  ProgressBar.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct ProgressBar: View {
    let progress: Double
    let height: CGFloat = 8
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(Theme.cardBackground)
                    .frame(height: height)
                
                RoundedRectangle(cornerRadius: height / 2)
                    .fill(Theme.accent)
                    .frame(width: geometry.size.width * min(progress, 1.0), height: height)
            }
        }
        .frame(height: height)
    }
}
