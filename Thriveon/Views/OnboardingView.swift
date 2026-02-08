//
//  OnboardingView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel = OnboardingViewModel()
    @AppStorage(Constants.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    
    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if viewModel.currentStep == 0 {
                    welcomeStep
                } else if viewModel.currentStep == 1 {
                    habitTrackingStep
                } else if viewModel.currentStep == 2 {
                    insightsStep
                } else {
                    motivationStep
                }
                
                Spacer()
                
                navigationButtons
            }
            .padding(Theme.spacingXL)
        }
    }
    
    private var welcomeStep: some View {
        VStack(spacing: Theme.spacingXXL) {
            Spacer()
            
            Image(systemName: "sparkles")
                .font(.system(size: 80))
                .foregroundColor(Theme.accent)
                .padding(.bottom, Theme.spacingL)
            
            Text("Welcome to Thriveon")
                .font(Theme.largeTitle())
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.center)
            
            Text("Your personal companion for building better habits and achieving your goals")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingL)
            
            VStack(spacing: Theme.spacingM) {
                Text("What should we call you?")
                    .font(Theme.headline())
                    .foregroundColor(Theme.textPrimary)
                
                TextField("Enter your name", text: $viewModel.userName)
                    .font(Theme.body())
                    .foregroundColor(Theme.textPrimary)
                    .padding(Theme.spacingL)
                    .background(Theme.cardBackground)
                    .cornerRadius(Theme.cornerRadiusM)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, Theme.spacingXL)
            
            Spacer()
        }
    }
    
    private var habitTrackingStep: some View {
        VStack(spacing: Theme.spacingXXL) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(Theme.accent)
                .padding(.bottom, Theme.spacingL)
            
            Text("Track Your Habits")
                .font(Theme.largeTitle())
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.center)
            
            Text("Create custom habits and track your progress with beautiful visualizations")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingL)
            
            VStack(spacing: Theme.spacingM) {
                featureRow(icon: "calendar", title: "Daily Tracking", description: "Mark habits complete each day")
                featureRow(icon: "chart.line.uptrend.xyaxis", title: "Progress Visualization", description: "See your journey unfold")
                featureRow(icon: "bell.badge.fill", title: "Smart Reminders", description: "Never miss a habit")
            }
            .padding(.top, Theme.spacingXL)
            
            Spacer()
        }
    }
    
    private var insightsStep: some View {
        VStack(spacing: Theme.spacingXXL) {
            Spacer()
            
            Image(systemName: "chart.bar.fill")
                .font(.system(size: 80))
                .foregroundColor(Theme.accent)
                .padding(.bottom, Theme.spacingL)
            
            Text("Get Insights")
                .font(Theme.largeTitle())
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.center)
            
            Text("Understand your patterns with powerful analytics and personalized recommendations")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingL)
            
            VStack(spacing: Theme.spacingM) {
                featureRow(icon: "chart.pie.fill", title: "Category Analysis", description: "See where you focus")
                featureRow(icon: "flame.fill", title: "Streak Tracking", description: "Build momentum daily")
                featureRow(icon: "star.fill", title: "Achievement System", description: "Celebrate your wins")
            }
            .padding(.top, Theme.spacingXL)
            
            Spacer()
        }
    }
    
    private var motivationStep: some View {
        VStack(spacing: Theme.spacingXXL) {
            Spacer()
            
            Image(systemName: "flame.fill")
                .font(.system(size: 80))
                .foregroundColor(Theme.accent)
                .padding(.bottom, Theme.spacingL)
            
            Text("Stay Motivated")
                .font(Theme.largeTitle())
                .foregroundColor(Theme.textPrimary)
                .multilineTextAlignment(.center)
            
            Text("Receive daily inspiration and celebrate your achievements along the way")
                .font(Theme.body())
                .foregroundColor(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Theme.spacingL)
            
            VStack(alignment: .leading, spacing: Theme.spacingM) {
                Text("Select your interests:")
                    .font(Theme.headline())
                    .foregroundColor(Theme.textPrimary)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: Theme.spacingM) {
                    ForEach(Constants.habitCategories.prefix(6), id: \.self) { category in
                        categoryButton(category)
                    }
                }
            }
            .padding(.top, Theme.spacingXL)
            
            Spacer()
        }
    }
    
    private func featureRow(icon: String, title: String, description: String) -> some View {
        HStack(spacing: Theme.spacingL) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(Theme.accent)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: Theme.spacingXS) {
                Text(title)
                    .font(Theme.headline())
                    .foregroundColor(Theme.textPrimary)
                
                Text(description)
                    .font(Theme.caption())
                    .foregroundColor(Theme.textSecondary)
            }
            
            Spacer()
        }
        .padding(Theme.spacingL)
        .background(Theme.cardBackground)
        .cornerRadius(Theme.cornerRadiusM)
    }
    
    private func categoryButton(_ category: String) -> some View {
        Button(action: {
            if viewModel.selectedCategories.contains(category) {
                viewModel.selectedCategories.remove(category)
            } else {
                viewModel.selectedCategories.insert(category)
            }
        }) {
            Text(category)
                .font(Theme.callout())
                .foregroundColor(viewModel.selectedCategories.contains(category) ? Theme.background : Theme.textPrimary)
                .padding(.horizontal, Theme.spacingL)
                .padding(.vertical, Theme.spacingM)
                .frame(maxWidth: .infinity)
                .background(viewModel.selectedCategories.contains(category) ? Theme.accent : Theme.cardBackground)
                .cornerRadius(Theme.cornerRadiusM)
        }
    }
    
    private var navigationButtons: some View {
        VStack(spacing: Theme.spacingL) {
            HStack(spacing: 0) {
                ForEach(0..<viewModel.steps.count, id: \.self) { index in
                    Rectangle()
                        .fill(index <= viewModel.currentStep ? Theme.accent : Theme.cardBackground)
                        .frame(height: 4)
                        .cornerRadius(2)
                    
                    if index < viewModel.steps.count - 1 {
                        Spacer()
                            .frame(width: Theme.spacingS)
                    }
                }
            }
            .padding(.bottom, Theme.spacingL)
            
            HStack(spacing: Theme.spacingL) {
                if viewModel.currentStep > 0 {
                    Button(action: {
                        viewModel.previousStep()
                    }) {
                        Text("Back")
                            .font(Theme.headline())
                            .foregroundColor(Theme.textSecondary)
                            .frame(maxWidth: .infinity)
                            .padding(Theme.spacingL)
                            .background(Theme.cardBackground)
                            .cornerRadius(Theme.cornerRadiusM)
                    }
                }
                
                Button(action: {
                    if viewModel.isLastStep {
                        viewModel.completeOnboarding()
                        hasCompletedOnboarding = true
                    } else {
                        viewModel.nextStep()
                    }
                }) {
                    Text(viewModel.isLastStep ? "Get Started" : "Continue")
                        .font(Theme.headline())
                        .foregroundColor(Theme.background)
                        .frame(maxWidth: .infinity)
                        .padding(Theme.spacingL)
                        .background(viewModel.canProceed ? Theme.accent : Theme.cardBackground)
                        .cornerRadius(Theme.cornerRadiusM)
                }
                .disabled(!viewModel.canProceed)
            }
        }
    }
}

#Preview("iPhone SE") {
    OnboardingView()
        .previewDevice(PreviewDevices.iPhoneSE)
}

#Preview("iPhone 15 Pro Max") {
    OnboardingView()
        .previewDevice(PreviewDevices.iPhone15ProMax)
}

#Preview("iPad Air 11-inch") {
    OnboardingView()
        .previewDevice(PreviewDevices.iPadAir11)
}
