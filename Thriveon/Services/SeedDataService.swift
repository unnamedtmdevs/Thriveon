//
//  SeedDataService.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation

class SeedDataService {
    static let shared = SeedDataService()
    
    private init() {}
    
    // Флаг для включения seed данных (установите true для демо)
    static let useSeedData = false
    
    func createSeedDataIfNeeded() {
        let hasCreatedSeedData = UserDefaults.standard.bool(forKey: "hasCreatedSeedData")
        
        guard SeedDataService.useSeedData && !hasCreatedSeedData else {
            return
        }
        
        let dataService = DataService.shared
        
        // Создаем тестовые привычки
        let habits = createSampleHabits()
        
        // Добавляем привычки
        for habit in habits {
            dataService.habits.append(habit)
        }
        
        // Обновляем профиль пользователя
        updateUserProfileWithSeedData(habits: habits)
        
        // Сохраняем данные
        dataService.saveHabits()
        dataService.saveUserProfile()
        
        // Отмечаем, что seed данные созданы
        UserDefaults.standard.set(true, forKey: "hasCreatedSeedData")
        
        print("✅ Seed данные успешно созданы!")
    }
    
    private func createSampleHabits() -> [Habit] {
        let calendar = Calendar.current
        let today = Date()
        
        // Habit 1: Morning Meditation (excellent habit with long streak)
        let meditationDates = generateCompletionDates(
            startDaysAgo: 45,
            endDaysAgo: 0,
            completionRate: 0.95
        )
        let meditation = Habit(
            name: "Morning Meditation",
            category: "Mindfulness",
            goal: "Start each day with calm and focus",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 7, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -45, to: today)!,
            completionDates: meditationDates,
            isActive: true,
            color: "AccentColor"
        )
        
        // Habit 2: Exercise (good habit)
        let workoutDates = generateCompletionDates(
            startDaysAgo: 60,
            endDaysAgo: 0,
            completionRate: 0.85
        )
        let workout = Habit(
            name: "Daily Exercise",
            category: "Health & Fitness",
            goal: "Stay healthy and energized",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 18, minute: 30, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -60, to: today)!,
            completionDates: workoutDates,
            isActive: true,
            color: "SuccessColor"
        )
        
        // Habit 3: Reading (moderate habit)
        let readingDates = generateCompletionDates(
            startDaysAgo: 30,
            endDaysAgo: 0,
            completionRate: 0.70
        )
        let reading = Habit(
            name: "Read for 30 minutes",
            category: "Learning",
            goal: "Expand knowledge and imagination",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 21, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -30, to: today)!,
            completionDates: readingDates,
            isActive: true,
            color: "WarningColor"
        )
        
        // Habit 4: Guitar Practice (new habit)
        let guitarDates = generateCompletionDates(
            startDaysAgo: 14,
            endDaysAgo: 0,
            completionRate: 0.60
        )
        let guitar = Habit(
            name: "Practice Guitar",
            category: "Creativity",
            goal: "Master my favorite instrument",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 19, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -14, to: today)!,
            completionDates: guitarDates,
            isActive: true,
            color: "AccentColor"
        )
        
        // Habit 5: Language Learning (regular habit)
        let languageDates = generateCompletionDates(
            startDaysAgo: 40,
            endDaysAgo: 0,
            completionRate: 0.75
        )
        let language = Habit(
            name: "Learn Spanish",
            category: "Learning",
            goal: "Improve language skills",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 20, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -40, to: today)!,
            completionDates: languageDates,
            isActive: true,
            color: "SuccessColor"
        )
        
        // Habit 6: Daily Planning (morning habit)
        let planningDates = generateCompletionDates(
            startDaysAgo: 25,
            endDaysAgo: 0,
            completionRate: 0.90
        )
        let planning = Habit(
            name: "Plan My Day",
            category: "Productivity",
            goal: "Organize day for maximum productivity",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 8, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -25, to: today)!,
            completionDates: planningDates,
            isActive: true,
            color: "AccentColor"
        )
        
        // Habit 7: Gratitude (evening habit)
        let gratitudeDates = generateCompletionDates(
            startDaysAgo: 20,
            endDaysAgo: 0,
            completionRate: 0.80
        )
        let gratitude = Habit(
            name: "Write 3 Gratitudes",
            category: "Mindfulness",
            goal: "Develop positive mindset",
            frequency: .daily,
            reminderTime: calendar.date(bySettingHour: 22, minute: 0, second: 0, of: today),
            createdDate: calendar.date(byAdding: .day, value: -20, to: today)!,
            completionDates: gratitudeDates,
            isActive: true,
            color: "WarningColor"
        )
        
        // Habit 8: Healthy Eating (inactive - for example)
        let healthyEatingDates = generateCompletionDates(
            startDaysAgo: 15,
            endDaysAgo: 5,
            completionRate: 0.50
        )
        let healthyEating = Habit(
            name: "Eat Healthy",
            category: "Health & Fitness",
            goal: "Maintain balanced nutrition",
            frequency: .daily,
            createdDate: calendar.date(byAdding: .day, value: -15, to: today)!,
            completionDates: healthyEatingDates,
            isActive: false,
            color: "SuccessColor"
        )
        
        return [meditation, workout, reading, guitar, language, planning, gratitude, healthyEating]
    }
    
    private func generateCompletionDates(startDaysAgo: Int, endDaysAgo: Int, completionRate: Double) -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        var dates: [Date] = []
        
        for daysAgo in (endDaysAgo...startDaysAgo).reversed() {
            // Используем случайность с учетом процента выполнения
            if Double.random(in: 0...1) < completionRate {
                if let date = calendar.date(byAdding: .day, value: -daysAgo, to: today) {
                    // Добавляем случайное время в течение дня
                    let hour = Int.random(in: 6...22)
                    let minute = Int.random(in: 0...59)
                    if let dateWithTime = calendar.date(bySettingHour: hour, minute: minute, second: 0, of: date) {
                        dates.append(dateWithTime)
                    }
                }
            }
        }
        
        return dates
    }
    
    private func updateUserProfileWithSeedData(habits: [Habit]) {
        let dataService = DataService.shared
        let calendar = Calendar.current
        
        // Update user name
        dataService.userProfile.name = "Alex"
        
        // Устанавливаем дату присоединения (2 месяца назад)
        dataService.userProfile.joinDate = calendar.date(byAdding: .month, value: -2, to: Date()) ?? Date()
        
        // Подсчитываем статистику
        dataService.userProfile.totalHabitsCreated = habits.count
        
        // Подсчитываем общее количество выполнений
        let totalCompletions = habits.reduce(0) { $0 + $1.completionDates.count }
        dataService.userProfile.totalCompletions = totalCompletions
        
        // Находим максимальный текущий стрик
        let activeHabits = habits.filter { $0.isActive }
        let currentStreaks = activeHabits.map { $0.currentStreak }
        dataService.userProfile.currentStreak = currentStreaks.max() ?? 0
        
        // Устанавливаем лучший стрик (немного больше текущего для реалистичности)
        dataService.userProfile.longestStreak = max(dataService.userProfile.currentStreak + 3, 15)
        
        // Устанавливаем предпочитаемые категории
        dataService.userProfile.preferredCategories = [
            "Mindfulness",
            "Health & Fitness",
            "Learning",
            "Productivity"
        ]
    }
    
    func resetSeedData() {
        UserDefaults.standard.set(false, forKey: "hasCreatedSeedData")
        DataService.shared.resetAllData()
        print("🔄 Seed данные сброшены")
    }
}
