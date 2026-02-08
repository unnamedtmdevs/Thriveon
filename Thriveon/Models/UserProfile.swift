//
//  UserProfile.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation

struct UserProfile: Codable {
    var name: String
    var joinDate: Date
    var totalHabitsCreated: Int
    var currentStreak: Int
    var longestStreak: Int
    var totalCompletions: Int
    var preferredCategories: [String]
    
    init(
        name: String = "Achiever",
        joinDate: Date = Date(),
        totalHabitsCreated: Int = 0,
        currentStreak: Int = 0,
        longestStreak: Int = 0,
        totalCompletions: Int = 0,
        preferredCategories: [String] = []
    ) {
        self.name = name
        self.joinDate = joinDate
        self.totalHabitsCreated = totalHabitsCreated
        self.currentStreak = currentStreak
        self.longestStreak = longestStreak
        self.totalCompletions = totalCompletions
        self.preferredCategories = preferredCategories
    }
}
