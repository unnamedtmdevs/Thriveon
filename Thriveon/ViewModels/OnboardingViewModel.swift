//
//  OnboardingViewModel.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation
import SwiftUI
import Combine

class OnboardingViewModel: ObservableObject {
    @Published var currentStep: Int = 0
    @Published var userName: String = ""
    @Published var selectedCategories: Set<String> = []
    
    let steps = Constants.onboardingSteps
    
    var isLastStep: Bool {
        currentStep == steps.count - 1
    }
    
    var canProceed: Bool {
        if currentStep == 0 && userName.isEmpty {
            return false
        }
        return true
    }
    
    func nextStep() {
        if currentStep < steps.count - 1 {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                currentStep += 1
            }
        }
    }
    
    func previousStep() {
        if currentStep > 0 {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                currentStep -= 1
            }
        }
    }
    
    func completeOnboarding() {
        let dataService = DataService.shared
        dataService.updateUserProfile(
            name: userName.isEmpty ? "Achiever" : userName,
            preferredCategories: Array(selectedCategories)
        )
        
        UserDefaults.standard.set(true, forKey: Constants.hasCompletedOnboarding)
    }
}
