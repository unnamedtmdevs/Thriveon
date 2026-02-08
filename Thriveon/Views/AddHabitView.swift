//
//  AddHabitView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: DashboardViewModel
    
    @State private var habitName = ""
    @State private var selectedCategory = Constants.habitCategories[0]
    @State private var goal = ""
    @State private var frequency = HabitFrequency.daily
    @State private var enableReminder = false
    @State private var reminderTime = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: Theme.spacingXL) {
                        VStack(alignment: .leading, spacing: Theme.spacingM) {
                            Text("Habit Name")
                                .font(Theme.headline())
                                .foregroundColor(Theme.textPrimary)
                            
                            TextField("e.g., Morning Meditation", text: $habitName)
                                .font(Theme.body())
                                .foregroundColor(Theme.textPrimary)
                                .padding(Theme.spacingL)
                                .background(Theme.cardBackground)
                                .cornerRadius(Theme.cornerRadiusM)
                        }
                        
                        VStack(alignment: .leading, spacing: Theme.spacingM) {
                            Text("Category")
                                .font(Theme.headline())
                                .foregroundColor(Theme.textPrimary)
                            
                            Picker("Category", selection: $selectedCategory) {
                                ForEach(Constants.habitCategories, id: \.self) { category in
                                    Text(category).tag(category)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(height: 150)
                            .background(Theme.cardBackground)
                            .cornerRadius(Theme.cornerRadiusM)
                        }
                        
                        VStack(alignment: .leading, spacing: Theme.spacingM) {
                            Text("Goal")
                                .font(Theme.headline())
                                .foregroundColor(Theme.textPrimary)
                            
                            TextField("Why is this important to you?", text: $goal)
                                .font(Theme.body())
                                .foregroundColor(Theme.textPrimary)
                                .padding(Theme.spacingL)
                                .background(Theme.cardBackground)
                                .cornerRadius(Theme.cornerRadiusM)
                        }
                        
                        VStack(alignment: .leading, spacing: Theme.spacingM) {
                            Text("Frequency")
                                .font(Theme.headline())
                                .foregroundColor(Theme.textPrimary)
                            
                            Picker("Frequency", selection: $frequency) {
                                ForEach(HabitFrequency.allCases, id: \.self) { freq in
                                    Label(freq.rawValue, systemImage: freq.icon)
                                        .tag(freq)
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Theme.cardBackground)
                            .cornerRadius(Theme.cornerRadiusM)
                        }
                        
                        VStack(alignment: .leading, spacing: Theme.spacingM) {
                            Toggle(isOn: $enableReminder) {
                                Text("Reminder")
                                    .font(Theme.headline())
                                    .foregroundColor(Theme.textPrimary)
                            }
                            .tint(Theme.accent)
                            
                            if enableReminder {
                                DatePicker("Time", selection: $reminderTime, displayedComponents: .hourAndMinute)
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                                    .background(Theme.cardBackground)
                                    .cornerRadius(Theme.cornerRadiusM)
                            }
                        }
                        
                        Button(action: saveHabit) {
                            Text("Create Habit")
                                .font(Theme.headline())
                                .foregroundColor(Theme.background)
                                .frame(maxWidth: .infinity)
                                .padding(Theme.spacingL)
                                .background(habitName.isEmpty ? Theme.cardBackground : Theme.accent)
                                .cornerRadius(Theme.cornerRadiusL)
                        }
                        .disabled(habitName.isEmpty)
                        .padding(.top, Theme.spacingL)
                    }
                    .padding(Theme.spacingL)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(Theme.textSecondary)
                }
            }
        }
    }
    
    private func saveHabit() {
        let newHabit = Habit(
            name: habitName,
            category: selectedCategory,
            goal: goal,
            frequency: frequency,
            reminderTime: enableReminder ? reminderTime : nil
        )
        
        viewModel.addHabit(newHabit)
        presentationMode.wrappedValue.dismiss()
    }
}
