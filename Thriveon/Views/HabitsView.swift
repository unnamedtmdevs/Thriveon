//
//  HabitsView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct HabitsView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var showingAddHabit = false
    @State private var selectedHabit: Habit?
    
    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()
            
            if viewModel.habits.isEmpty {
                emptyState
            } else {
                habitsList
            }
        }
        .navigationTitle("All Habits")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showingAddHabit = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Theme.accent)
                }
            }
        }
        .sheet(isPresented: $showingAddHabit) {
            AddHabitView(viewModel: viewModel)
        }
        .sheet(item: $selectedHabit) { habit in
            HabitDetailView(habit: habit, viewModel: viewModel)
        }
    }
    
    private var emptyState: some View {
        VStack(spacing: Theme.spacingXL) {
            Image(systemName: "list.bullet.circle")
                .font(.system(size: 80))
                .foregroundColor(Theme.textSecondary)
            
            Text("No Habits Yet")
                .font(Theme.title())
                .foregroundColor(Theme.textPrimary)
            
            Text("Create your first habit to start building better routines")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingXXL)
            
            Button(action: {
                showingAddHabit = true
            }) {
                Label("Create Habit", systemImage: "plus.circle.fill")
                    .font(Theme.headline())
                    .foregroundColor(Theme.background)
                    .padding(.horizontal, Theme.spacingXL)
                    .padding(.vertical, Theme.spacingL)
                    .background(Theme.accent)
                    .cornerRadius(Theme.cornerRadiusL)
            }
            .padding(.top, Theme.spacingL)
        }
    }
    
    private var habitsList: some View {
        ScrollView {
            VStack(spacing: Theme.spacingL) {
                ForEach(viewModel.habits) { habit in
                    HabitCard(habit: habit) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.toggleHabitCompletion(habit.id)
                        }
                    }
                    .onTapGesture {
                        selectedHabit = habit
                    }
                }
            }
            .padding(Theme.spacingL)
        }
    }
}
