//
//  AnalyticsService.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation

struct AnalyticsData {
    let totalHabits: Int
    let activeHabits: Int
    let completionRate: Double
    let currentStreak: Int
    let longestStreak: Int
    let totalCompletions: Int
    let weeklyProgress: [DayProgress]
    let categoryBreakdown: [CategoryStats]
    let topHabits: [Habit]
}

struct DayProgress: Identifiable {
    let id = UUID()
    let date: Date
    let completions: Int
    let dayName: String
}

struct CategoryStats: Identifiable {
    let id = UUID()
    let category: String
    let count: Int
    let percentage: Double
}

class AnalyticsService {
    static let shared = AnalyticsService()
    
    private init() {}
    
    func generateAnalytics(habits: [Habit], userProfile: UserProfile) -> AnalyticsData {
        let activeHabits = habits.filter { $0.isActive }
        let totalHabits = habits.count
        let activeCount = activeHabits.count
        
        let completionRate = calculateOverallCompletionRate(habits: activeHabits)
        let weeklyProgress = calculateWeeklyProgress(habits: activeHabits)
        let categoryBreakdown = calculateCategoryBreakdown(habits: habits)
        let topHabits = getTopHabits(habits: activeHabits)
        
        return AnalyticsData(
            totalHabits: totalHabits,
            activeHabits: activeCount,
            completionRate: completionRate,
            currentStreak: userProfile.currentStreak,
            longestStreak: userProfile.longestStreak,
            totalCompletions: userProfile.totalCompletions,
            weeklyProgress: weeklyProgress,
            categoryBreakdown: categoryBreakdown,
            topHabits: topHabits
        )
    }
    
    private func calculateOverallCompletionRate(habits: [Habit]) -> Double {
        guard !habits.isEmpty else { return 0 }
        
        let rates = habits.map { $0.completionRate }
        let sum = rates.reduce(0, +)
        return sum / Double(habits.count)
    }
    
    private func calculateWeeklyProgress(habits: [Habit]) -> [DayProgress] {
        let calendar = Calendar.current
        let today = Date()
        var progress: [DayProgress] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        for i in (0..<7).reversed() {
            guard let date = calendar.date(byAdding: .day, value: -i, to: today) else { continue }
            let startOfDay = calendar.startOfDay(for: date)
            
            var completions = 0
            for habit in habits {
                if habit.completionDates.contains(where: { calendar.startOfDay(for: $0) == startOfDay }) {
                    completions += 1
                }
            }
            
            progress.append(DayProgress(
                date: date,
                completions: completions,
                dayName: dateFormatter.string(from: date)
            ))
        }
        
        return progress
    }
    
    private func calculateCategoryBreakdown(habits: [Habit]) -> [CategoryStats] {
        var categoryCounts: [String: Int] = [:]
        
        for habit in habits where habit.isActive {
            categoryCounts[habit.category, default: 0] += 1
        }
        
        let total = Double(habits.filter { $0.isActive }.count)
        guard total > 0 else { return [] }
        
        return categoryCounts.map { category, count in
            CategoryStats(
                category: category,
                count: count,
                percentage: Double(count) / total
            )
        }.sorted { $0.count > $1.count }
    }
    
    private func getTopHabits(habits: [Habit]) -> [Habit] {
        return habits
            .sorted { $0.currentStreak > $1.currentStreak }
            .prefix(3)
            .map { $0 }
    }
    
    func getDailyQuote() -> String {
        let userDefaults = UserDefaults.standard
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastDate = userDefaults.object(forKey: Constants.lastQuoteDateKey) as? Date,
           calendar.isDate(lastDate, inSameDayAs: today),
           let savedQuote = userDefaults.string(forKey: Constants.dailyQuoteKey) {
            return savedQuote
        }
        
        let quote = Constants.motivationalQuotes.randomElement() ?? Constants.motivationalQuotes[0]
        userDefaults.set(quote, forKey: Constants.dailyQuoteKey)
        userDefaults.set(today, forKey: Constants.lastQuoteDateKey)
        
        return quote
    }
}
