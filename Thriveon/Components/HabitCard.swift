//
//  HabitCard.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct HabitCard: View {
    let habit: Habit
    let onToggle: () -> Void
    
    var body: some View {
        HStack(spacing: Theme.spacingL) {
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .stroke(Theme.accent, lineWidth: 2)
                        .frame(width: 44, height: 44)
                    
                    if habit.isCompletedToday() {
                        Circle()
                            .fill(Theme.accent)
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: "checkmark")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Theme.background)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: Theme.spacingS) {
                Text(habit.name)
                    .font(Theme.headline())
                    .foregroundColor(Theme.textPrimary)
                    .lineLimit(1)
                
                HStack(spacing: Theme.spacingM) {
                    Label(habit.category, systemImage: "tag.fill")
                        .font(Theme.caption())
                        .foregroundColor(Theme.textSecondary)
                    
                    if habit.currentStreak > 0 {
                        Label("\(habit.currentStreak) day streak", systemImage: "flame.fill")
                            .font(Theme.caption())
                            .foregroundColor(Theme.accent)
                    }
                }
            }
            
            Spacer()
            
            VStack(spacing: Theme.spacingXS) {
                Text("\(Int(habit.completionRate * 100))%")
                    .font(Theme.headline())
                    .foregroundColor(Theme.accent)
                
                Text("complete")
                    .font(Theme.caption())
                    .foregroundColor(Theme.textSecondary)
            }
        }
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
}
