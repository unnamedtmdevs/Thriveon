//
//  HabitModel.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var category: String
    var goal: String
    var frequency: HabitFrequency
    var reminderTime: Date?
    var createdDate: Date
    var completionDates: [Date]
    var isActive: Bool
    var color: String
    
    init(
        id: UUID = UUID(),
        name: String,
        category: String,
        goal: String,
        frequency: HabitFrequency,
        reminderTime: Date? = nil,
        createdDate: Date = Date(),
        completionDates: [Date] = [],
        isActive: Bool = true,
        color: String = "AccentColor"
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.goal = goal
        self.frequency = frequency
        self.reminderTime = reminderTime
        self.createdDate = createdDate
        self.completionDates = completionDates
        self.isActive = isActive
        self.color = color
    }
    
    var currentStreak: Int {
        guard !completionDates.isEmpty else { return 0 }
        
        let calendar = Calendar.current
        let sortedDates = completionDates.sorted(by: >)
        
        guard let mostRecent = sortedDates.first else { return 0 }
        
        let today = calendar.startOfDay(for: Date())
        let mostRecentDay = calendar.startOfDay(for: mostRecent)
        
        guard today == mostRecentDay || calendar.dateComponents([.day], from: mostRecentDay, to: today).day == 1 else {
            return 0
        }
        
        var streak = 0
        var currentDate = today
        
        for date in sortedDates {
            let dateDay = calendar.startOfDay(for: date)
            
            if dateDay == currentDate {
                streak += 1
                currentDate = calendar.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
            } else if dateDay < currentDate {
                let daysDiff = calendar.dateComponents([.day], from: dateDay, to: currentDate).day ?? 0
                if daysDiff > 1 {
                    break
                }
            }
        }
        
        return streak
    }
    
    var completionRate: Double {
        let calendar = Calendar.current
        let daysSinceCreation = calendar.dateComponents([.day], from: calendar.startOfDay(for: createdDate), to: calendar.startOfDay(for: Date())).day ?? 0
        
        guard daysSinceCreation > 0 else { return 0 }
        
        let expectedCompletions = Double(daysSinceCreation + 1)
        let actualCompletions = Double(completionDates.count)
        
        return min(actualCompletions / expectedCompletions, 1.0)
    }
    
    func isCompletedToday() -> Bool {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        return completionDates.contains { date in
            calendar.startOfDay(for: date) == today
        }
    }
    
    mutating func toggleCompletion() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let index = completionDates.firstIndex(where: { calendar.startOfDay(for: $0) == today }) {
            completionDates.remove(at: index)
        } else {
            completionDates.append(Date())
        }
    }
}

enum HabitFrequency: String, Codable, CaseIterable {
    case daily = "Daily"
    case weekly = "Weekly"
    case custom = "Custom"
    
    var icon: String {
        switch self {
        case .daily:
            return "sun.max.fill"
        case .weekly:
            return "calendar"
        case .custom:
            return "slider.horizontal.3"
        }
    }
}
