//
//  AnalyticsView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct AnalyticsView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            if let analytics = viewModel.analyticsData {
                VStack(spacing: Theme.spacingXL) {
                    overviewSection(analytics: analytics)
                    weeklyProgressSection(analytics: analytics)
                    categoryBreakdownSection(analytics: analytics)
                    topHabitsSection(analytics: analytics)
                }
                .padding(Theme.spacingL)
            } else {
                emptyState
            }
        }
        .background(Theme.background)
    }
    
    private func overviewSection(analytics: AnalyticsData) -> some View {
        VStack(alignment: .leading, spacing: Theme.spacingL) {
            Text("Overview")
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Theme.spacingL) {
                StatCard(
                    title: "Active Habits",
                    value: "\(analytics.activeHabits)",
                    icon: "checkmark.circle.fill",
                    color: Theme.accent
                )
                
                StatCard(
                    title: "Completion Rate",
                    value: "\(Int(analytics.completionRate * 100))%",
                    icon: "chart.bar.fill",
                    color: Theme.success
                )
            }
        }
    }
    
    private func weeklyProgressSection(analytics: AnalyticsData) -> some View {
        VStack(alignment: .leading, spacing: Theme.spacingL) {
            Text("Weekly Progress")
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
            
            VStack(spacing: Theme.spacingM) {
                HStack(alignment: .bottom, spacing: Theme.spacingS) {
                    ForEach(analytics.weeklyProgress) { day in
                        VStack(spacing: Theme.spacingS) {
                            Text("\(day.completions)")
                                .font(Theme.caption())
                                .foregroundColor(Theme.textPrimary)
                            
                            Rectangle()
                                .fill(day.completions > 0 ? Theme.accent : Theme.cardBackground)
                                .frame(height: max(CGFloat(day.completions) * 30, 10))
                                .cornerRadius(Theme.cornerRadiusS)
                            
                            Text(day.dayName)
                                .font(Theme.caption())
                                .foregroundColor(Theme.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .frame(height: 200)
            }
            .padding(Theme.spacingL)
            .background(Theme.cardBackground)
            .cornerRadius(Theme.cornerRadiusL)
        }
    }
    
    private func categoryBreakdownSection(analytics: AnalyticsData) -> some View {
        VStack(alignment: .leading, spacing: Theme.spacingL) {
            Text("Category Breakdown")
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
            
            if analytics.categoryBreakdown.isEmpty {
                Text("No data available")
                    .font(Theme.body())
                    .foregroundColor(Theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, Theme.spacingXL)
                    .background(Theme.cardBackground)
                    .cornerRadius(Theme.cornerRadiusL)
            } else {
                VStack(spacing: Theme.spacingM) {
                    ForEach(analytics.categoryBreakdown) { stat in
                        HStack {
                            Text(stat.category)
                                .font(Theme.body())
                                .foregroundColor(Theme.textPrimary)
                            
                            Spacer()
                            
                            Text("\(stat.count)")
                                .font(Theme.headline())
                                .foregroundColor(Theme.accent)
                            
                            Text("(\(Int(stat.percentage * 100))%)")
                                .font(Theme.caption())
                                .foregroundColor(Theme.textSecondary)
                        }
                        .padding(Theme.spacingL)
                        .background(Theme.cardBackground)
                        .cornerRadius(Theme.cornerRadiusM)
                    }
                }
            }
        }
    }
    
    private func topHabitsSection(analytics: AnalyticsData) -> some View {
        VStack(alignment: .leading, spacing: Theme.spacingL) {
            Text("Top Performers")
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
            
            if analytics.topHabits.isEmpty {
                Text("No habits tracked yet")
                    .font(Theme.body())
                    .foregroundColor(Theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, Theme.spacingXL)
                    .background(Theme.cardBackground)
                    .cornerRadius(Theme.cornerRadiusL)
            } else {
                VStack(spacing: Theme.spacingM) {
                    ForEach(Array(analytics.topHabits.enumerated()), id: \.element.id) { index, habit in
                        HStack(spacing: Theme.spacingL) {
                            ZStack {
                                Circle()
                                    .fill(Theme.accent)
                                    .frame(width: 40, height: 40)
                                
                                Text("#\(index + 1)")
                                    .font(Theme.headline())
                                    .foregroundColor(Theme.background)
                            }
                            
                            VStack(alignment: .leading, spacing: Theme.spacingXS) {
                                Text(habit.name)
                                    .font(Theme.headline())
                                    .foregroundColor(Theme.textPrimary)
                                
                                Text("\(habit.currentStreak) day streak")
                                    .font(Theme.caption())
                                    .foregroundColor(Theme.textSecondary)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "flame.fill")
                                .foregroundColor(Theme.accent)
                        }
                        .padding(Theme.spacingL)
                        .background(Theme.cardBackground)
                        .cornerRadius(Theme.cornerRadiusM)
                    }
                }
            }
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: Theme.spacingXL) {
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 80))
                .foregroundColor(Theme.textSecondary)
            
            Text("No Analytics Yet")
                .font(Theme.title())
                .foregroundColor(Theme.textPrimary)
            
            Text("Start tracking habits to see your insights and progress")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingXXL)
        }
        .padding(.vertical, Theme.spacingXXL)
    }
}
