//
//  DashboardView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct DashboardView: View {
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: Theme.spacingXL) {
                headerSection
                
                if !viewModel.dailyQuote.isEmpty {
                    quoteCard
                }
                
                statsGrid
                
                if !viewModel.activeHabits.isEmpty {
                    todayProgressSection
                    habitsSection
                } else {
                    emptyStateView
                }
            }
            .padding(Theme.spacingL)
        }
        .background(Theme.background)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: Theme.spacingS) {
            Text("Hello, \(viewModel.userProfile.name)!")
                .font(Theme.largeTitle())
                .foregroundColor(Theme.textPrimary)
            
            Text("Let's make today count")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var quoteCard: some View {
        HStack(spacing: Theme.spacingL) {
            Image(systemName: "quote.bubble.fill")
                .font(.system(size: 32))
                .foregroundColor(Theme.accent)
            
            Text(viewModel.dailyQuote)
                .font(Theme.callout())
                .foregroundColor(Theme.textPrimary)
                .lineLimit(3)
                .minimumScaleFactor(0.8)
        }
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
    
    private var statsGrid: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Theme.spacingL) {
            StatCard(
                title: "Current Streak",
                value: "\(viewModel.userProfile.currentStreak)",
                icon: "flame.fill",
                color: Theme.accent
            )
            
            StatCard(
                title: "Total Habits",
                value: "\(viewModel.activeHabits.count)",
                icon: "list.bullet.circle.fill",
                color: Theme.success
            )
            
            StatCard(
                title: "Completions",
                value: "\(viewModel.userProfile.totalCompletions)",
                icon: "checkmark.circle.fill",
                color: Theme.accent
            )
            
            StatCard(
                title: "Best Streak",
                value: "\(viewModel.userProfile.longestStreak)",
                icon: "trophy.fill",
                color: Theme.warning
            )
        }
    }
    
    private var todayProgressSection: some View {
        VStack(alignment: .leading, spacing: Theme.spacingM) {
            HStack {
                Text("Today's Progress")
                    .font(Theme.title2())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
                
                Text("\(Int(viewModel.todayCompletionRate * 100))%")
                    .font(Theme.headline())
                    .foregroundColor(Theme.accent)
            }
            
            ProgressBar(progress: viewModel.todayCompletionRate)
            
            Text("\(viewModel.activeHabits.filter { $0.isCompletedToday() }.count) of \(viewModel.activeHabits.count) habits completed")
                .font(Theme.caption())
                .foregroundColor(Theme.textSecondary)
        }
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
    
    private var habitsSection: some View {
        VStack(alignment: .leading, spacing: Theme.spacingL) {
            Text("Your Habits")
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
            
            ForEach(viewModel.activeHabits) { habit in
                HabitCard(habit: habit) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        viewModel.toggleHabitCompletion(habit.id)
                    }
                }
            }
        }
    }
    
    private var emptyStateView: some View {
        VStack(spacing: Theme.spacingXL) {
            Image(systemName: "sparkles")
                .font(.system(size: 60))
                .foregroundColor(Theme.textSecondary)
            
            Text("Start Your Journey")
                .font(Theme.title())
                .foregroundColor(Theme.textPrimary)
            
            Text("Create your first habit to begin tracking your progress and building better routines.")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingXL)
        }
        .padding(.vertical, Theme.spacingXXL)
    }
}
