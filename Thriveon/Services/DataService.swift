//
//  DataService.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation
import Combine

class DataService: ObservableObject {
    static let shared = DataService()
    
    @Published var userProfile: UserProfile
    @Published var habits: [Habit] = []
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private init() {
        self.userProfile = DataService.loadUserProfile()
        self.habits = DataService.loadHabits()
    }
    
    // MARK: - User Profile
    
    private static func loadUserProfile() -> UserProfile {
        guard let data = UserDefaults.standard.data(forKey: Constants.userProfileKey),
              let profile = try? JSONDecoder().decode(UserProfile.self, from: data) else {
            return UserProfile()
        }
        return profile
    }
    
    func saveUserProfile() {
        if let encoded = try? encoder.encode(userProfile) {
            userDefaults.set(encoded, forKey: Constants.userProfileKey)
        }
    }
    
    func updateUserProfile(name: String? = nil, preferredCategories: [String]? = nil) {
        if let name = name {
            userProfile.name = name
        }
        if let categories = preferredCategories {
            userProfile.preferredCategories = categories
        }
        saveUserProfile()
    }
    
    // MARK: - Habits
    
    private static func loadHabits() -> [Habit] {
        guard let data = UserDefaults.standard.data(forKey: Constants.habitsKey),
              let habits = try? JSONDecoder().decode([Habit].self, from: data) else {
            return []
        }
        return habits
    }
    
    func saveHabits() {
        if let encoded = try? encoder.encode(habits) {
            userDefaults.set(encoded, forKey: Constants.habitsKey)
        }
    }
    
    func addHabit(_ habit: Habit) {
        habits.append(habit)
        userProfile.totalHabitsCreated += 1
        saveHabits()
        saveUserProfile()
    }
    
    func updateHabit(_ habit: Habit) {
        if let index = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[index] = habit
            saveHabits()
        }
    }
    
    func deleteHabit(_ habit: Habit) {
        habits.removeAll { $0.id == habit.id }
        saveHabits()
    }
    
    func toggleHabitCompletion(_ habitId: UUID) {
        if let index = habits.firstIndex(where: { $0.id == habitId }) {
            let wasCompletedToday = habits[index].isCompletedToday()
            habits[index].toggleCompletion()
            
            if !wasCompletedToday {
                userProfile.totalCompletions += 1
            } else {
                userProfile.totalCompletions = max(0, userProfile.totalCompletions - 1)
            }
            
            updateStreaks()
            saveHabits()
            saveUserProfile()
        }
    }
    
    private func updateStreaks() {
        let currentStreaks = habits.filter { $0.isActive }.map { $0.currentStreak }
        let maxStreak = currentStreaks.max() ?? 0
        
        userProfile.currentStreak = maxStreak
        
        if maxStreak > userProfile.longestStreak {
            userProfile.longestStreak = maxStreak
        }
    }
    
    func resetAllData() {
        habits = []
        userProfile = UserProfile()
        saveHabits()
        saveUserProfile()
        userDefaults.set(false, forKey: Constants.hasCompletedOnboarding)
    }
}
