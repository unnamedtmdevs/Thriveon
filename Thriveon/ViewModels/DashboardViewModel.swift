//
//  DashboardViewModel.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var habits: [Habit] = []
    @Published var userProfile: UserProfile = UserProfile()
    @Published var analyticsData: AnalyticsData?
    @Published var dailyQuote: String = ""
    @Published var selectedTab: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let dataService = DataService.shared
    private let analyticsService = AnalyticsService.shared
    
    init() {
        setupSubscriptions()
        loadData()
    }
    
    private func setupSubscriptions() {
        dataService.$habits
            .sink { [weak self] habits in
                self?.habits = habits
                self?.refreshAnalytics()
            }
            .store(in: &cancellables)
        
        dataService.$userProfile
            .sink { [weak self] profile in
                self?.userProfile = profile
                self?.refreshAnalytics()
            }
            .store(in: &cancellables)
    }
    
    func loadData() {
        habits = dataService.habits
        userProfile = dataService.userProfile
        dailyQuote = analyticsService.getDailyQuote()
        refreshAnalytics()
    }
    
    func refreshAnalytics() {
        analyticsData = analyticsService.generateAnalytics(
            habits: habits,
            userProfile: userProfile
        )
    }
    
    func toggleHabitCompletion(_ habitId: UUID) {
        dataService.toggleHabitCompletion(habitId)
    }
    
    func addHabit(_ habit: Habit) {
        dataService.addHabit(habit)
    }
    
    func updateHabit(_ habit: Habit) {
        dataService.updateHabit(habit)
    }
    
    func deleteHabit(_ habit: Habit) {
        dataService.deleteHabit(habit)
    }
    
    var activeHabits: [Habit] {
        habits.filter { $0.isActive }
    }
    
    var todayCompletionRate: Double {
        let activeHabits = habits.filter { $0.isActive }
        guard !activeHabits.isEmpty else { return 0 }
        
        let completedToday = activeHabits.filter { $0.isCompletedToday() }.count
        return Double(completedToday) / Double(activeHabits.count)
    }
}
