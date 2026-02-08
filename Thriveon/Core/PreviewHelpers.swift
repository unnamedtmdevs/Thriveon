//
//  PreviewHelpers.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct PreviewDevices {
    static let iPhoneSE = PreviewDevice(rawValue: "iPhone SE (3rd generation)")
    static let iPhone15ProMax = PreviewDevice(rawValue: "iPhone 15 Pro Max")
    static let iPadAir11 = PreviewDevice(rawValue: "iPad Air 11-inch (M2)")
}

struct SampleData {
    static let habits: [Habit] = [
        Habit(
            name: "Morning Meditation",
            category: "Mindfulness",
            goal: "Start each day with calm and focus",
            frequency: .daily,
            createdDate: Calendar.current.date(byAdding: .day, value: -30, to: Date())!,
            completionDates: Array(0..<20).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
        ),
        Habit(
            name: "Exercise",
            category: "Health & Fitness",
            goal: "Stay healthy and energized",
            frequency: .daily,
            createdDate: Calendar.current.date(byAdding: .day, value: -45, to: Date())!,
            completionDates: Array(0..<15).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
        ),
        Habit(
            name: "Read for 30 minutes",
            category: "Learning",
            goal: "Expand knowledge and imagination",
            frequency: .daily,
            createdDate: Calendar.current.date(byAdding: .day, value: -20, to: Date())!,
            completionDates: Array(0..<10).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
        ),
        Habit(
            name: "Practice Guitar",
            category: "Creativity",
            goal: "Master my favorite instrument",
            frequency: .daily,
            createdDate: Calendar.current.date(byAdding: .day, value: -60, to: Date())!,
            completionDates: Array(0..<25).compactMap { Calendar.current.date(byAdding: .day, value: -$0, to: Date()) }
        )
    ]
    
    static let userProfile = UserProfile(
        name: "Alex",
        joinDate: Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
        totalHabitsCreated: 8,
        currentStreak: 12,
        longestStreak: 25,
        totalCompletions: 150,
        preferredCategories: ["Health & Fitness", "Mindfulness", "Learning"]
    )
}
