//
//  ThriveonApp.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

@main
struct ThriveonApp: App {
    @AppStorage(Constants.hasCompletedOnboarding) private var hasCompletedOnboarding = false
    
    init() {
        // Создаем seed данные при первом запуске
        SeedDataService.shared.createSeedDataIfNeeded()
    }
    
    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainView()
            } else {
                OnboardingView()
            }
        }
    }
}
