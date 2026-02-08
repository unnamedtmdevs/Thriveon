//
//  HabitDetailView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct HabitDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let habit: Habit
    @ObservedObject var viewModel: DashboardViewModel
    @State private var showingDeleteAlert = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.spacingXL) {
                        statsSection
                        goalSection
                        historySection
                    }
                    .padding(Theme.spacingL)
                }
            }
            .navigationTitle(habit.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Theme.accent)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingDeleteAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(Theme.accent)
                    }
                }
            }
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete Habit"),
                    message: Text("Are you sure you want to delete this habit? This action cannot be undone."),
                    primaryButton: .destructive(Text("Delete")) {
                        viewModel.deleteHabit(habit)
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
    }
    
    private var statsSection: some View {
        VStack(spacing: Theme.spacingL) {
            HStack(spacing: Theme.spacingL) {
                statBox(title: "Current Streak", value: "\(habit.currentStreak)", icon: "flame.fill")
                statBox(title: "Completion", value: "\(Int(habit.completionRate * 100))%", icon: "chart.bar.fill")
            }
            
            HStack(spacing: Theme.spacingL) {
                statBox(title: "Total Days", value: "\(habit.completionDates.count)", icon: "calendar")
                statBox(title: "Category", value: habit.category, icon: "tag.fill")
            }
        }
    }
    
    private func statBox(title: String, value: String, icon: String) -> some View {
        VStack(spacing: Theme.spacingM) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Theme.accent)
            
            Text(value)
                .font(Theme.title2())
                .foregroundColor(Theme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.6)
            
            Text(title)
                .font(Theme.caption())
                .foregroundColor(Theme.textSecondary)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity)
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
    
    private var goalSection: some View {
        VStack(alignment: .leading, spacing: Theme.spacingM) {
            Text("Your Goal")
                .font(Theme.headline())
                .foregroundColor(Theme.textPrimary)
            
            Text(habit.goal.isEmpty ? "No goal set" : habit.goal)
                .font(Theme.body())
                .foregroundColor(habit.goal.isEmpty ? Theme.textSecondary : Theme.textPrimary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
    
    private var historySection: some View {
        VStack(alignment: .leading, spacing: Theme.spacingM) {
            Text("Recent Activity")
                .font(Theme.headline())
                .foregroundColor(Theme.textPrimary)
            
            if habit.completionDates.isEmpty {
                Text("No activity yet")
                    .font(Theme.body())
                    .foregroundColor(Theme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, Theme.spacingXL)
            } else {
                let recentDates = habit.completionDates.sorted(by: >).prefix(10)
                ForEach(Array(recentDates), id: \.self) { date in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(Theme.success)
                        
                        Text(formatDate(date))
                            .font(Theme.body())
                            .foregroundColor(Theme.textPrimary)
                        
                        Spacer()
                    }
                    .padding(.vertical, Theme.spacingS)
                }
            }
        }
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusL)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
