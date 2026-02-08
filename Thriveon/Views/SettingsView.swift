//
//  SettingsView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: DashboardViewModel
    @State private var editingName = false
    @State private var newName = ""
    @State private var showingResetAlert = false
    @AppStorage(Constants.hasCompletedOnboarding) private var hasCompletedOnboarding = true
    
    var body: some View {
        ScrollView {
            VStack(spacing: Theme.spacingXL) {
                profileSection
                statsSection
                preferencesSection
                dangerZoneSection
            }
            .padding(Theme.spacingL)
        }
        .background(Theme.background)
        .sheet(isPresented: $editingName) {
            editNameSheet
        }
        .alert(isPresented: $showingResetAlert) {
            Alert(
                title: Text("Reset All Data"),
                message: Text("This will delete all your habits and progress. This action cannot be undone."),
                primaryButton: .destructive(Text("Reset")) {
                    resetAllData()
                },
                secondaryButton: .cancel()
            )
        }
    }
    
    private var profileSection: some View {
        VStack(spacing: Theme.spacingL) {
            HStack {
                Text("Profile")
                    .font(Theme.title2())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
            }
            
            VStack(spacing: Theme.spacingL) {
                HStack {
                    VStack(alignment: .leading, spacing: Theme.spacingS) {
                        Text("Name")
                            .font(Theme.caption())
                            .foregroundColor(Theme.textSecondary)
                        
                        Text(viewModel.userProfile.name)
                            .font(Theme.headline())
                            .foregroundColor(Theme.textPrimary)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        newName = viewModel.userProfile.name
                        editingName = true
                    }) {
                        Text("Edit")
                            .font(Theme.callout())
                            .foregroundColor(Theme.accent)
                    }
                }
                .padding(Theme.spacingL)
                .background(Theme.cardBackground)
                .cornerRadius(Theme.cornerRadiusM)
                
                HStack {
                    VStack(alignment: .leading, spacing: Theme.spacingS) {
                        Text("Member Since")
                            .font(Theme.caption())
                            .foregroundColor(Theme.textSecondary)
                        
                        Text(formatDate(viewModel.userProfile.joinDate))
                            .font(Theme.headline())
                            .foregroundColor(Theme.textPrimary)
                    }
                    
                    Spacer()
                }
                .padding(Theme.spacingL)
                .background(Theme.cardBackground)
                .cornerRadius(Theme.cornerRadiusM)
            }
        }
    }
    
    private var statsSection: some View {
        VStack(spacing: Theme.spacingL) {
            HStack {
                Text("Your Journey")
                    .font(Theme.title2())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
            }
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Theme.spacingL) {
                StatCard(
                    title: "Total Habits",
                    value: "\(viewModel.userProfile.totalHabitsCreated)",
                    icon: "list.bullet",
                    color: Theme.accent
                )
                
                StatCard(
                    title: "Completions",
                    value: "\(viewModel.userProfile.totalCompletions)",
                    icon: "checkmark.circle.fill",
                    color: Theme.success
                )
                
                StatCard(
                    title: "Current Streak",
                    value: "\(viewModel.userProfile.currentStreak)",
                    icon: "flame.fill",
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
    }
    
    private var preferencesSection: some View {
        VStack(spacing: Theme.spacingL) {
            HStack {
                Text("Preferences")
                    .font(Theme.title2())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
            }
            
            VStack(spacing: Theme.spacingM) {
                settingRow(
                    icon: "paintbrush.fill",
                    title: "Theme",
                    value: "Dark",
                    action: {}
                )
                
                settingRow(
                    icon: "bell.fill",
                    title: "Notifications",
                    value: "Manage",
                    action: {}
                )
            }
        }
    }
    
    private func settingRow(icon: String, title: String, value: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Theme.accent)
                    .frame(width: 30)
                
                Text(title)
                    .font(Theme.body())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
                
                Text(value)
                    .font(Theme.callout())
                    .foregroundColor(Theme.textSecondary)
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(Theme.textSecondary)
            }
            .padding(Theme.spacingL)
            .background(Theme.cardBackground)
            .cornerRadius(Theme.cornerRadiusM)
        }
    }
    
    private var dangerZoneSection: some View {
        VStack(spacing: Theme.spacingL) {
            HStack {
                Text("Danger Zone")
                    .font(Theme.title2())
                    .foregroundColor(Theme.textPrimary)
                
                Spacer()
            }
            
            Button(action: {
                showingResetAlert = true
            }) {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Theme.accent)
                    
                    Text("Reset All Data")
                        .font(Theme.body())
                        .foregroundColor(Theme.textPrimary)
                    
                    Spacer()
                }
                .padding(Theme.spacingL)
                .background(Theme.cardBackground)
                .cornerRadius(Theme.cornerRadiusM)
            }
        }
    }
    
    private var editNameSheet: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea()
                
                VStack(spacing: Theme.spacingXL) {
                    TextField("Enter your name", text: $newName)
                        .font(Theme.body())
                        .foregroundColor(Theme.textPrimary)
                        .padding(Theme.spacingL)
                        .background(Theme.cardBackground)
                        .cornerRadius(Theme.cornerRadiusM)
                    
                    Button(action: {
                        if !newName.isEmpty {
                            DataService.shared.updateUserProfile(name: newName)
                        }
                        editingName = false
                    }) {
                        Text("Save")
                            .font(Theme.headline())
                            .foregroundColor(Theme.background)
                            .frame(maxWidth: .infinity)
                            .padding(Theme.spacingL)
                            .background(newName.isEmpty ? Theme.cardBackground : Theme.accent)
                            .cornerRadius(Theme.cornerRadiusL)
                    }
                    .disabled(newName.isEmpty)
                    
                    Spacer()
                }
                .padding(Theme.spacingL)
            }
            .navigationTitle("Edit Name")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        editingName = false
                    }
                    .foregroundColor(Theme.textSecondary)
                }
            }
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }
    
    private func resetAllData() {
        DataService.shared.resetAllData()
        hasCompletedOnboarding = false
    }
}
