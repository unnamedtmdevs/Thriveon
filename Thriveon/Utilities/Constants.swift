//
//  Constants.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import Foundation

struct Constants {
    // MARK: - UserDefaults Keys
    static let hasCompletedOnboarding = "hasCompletedOnboarding"
    static let userProfileKey = "userProfile"
    static let habitsKey = "habits"
    static let dailyQuoteKey = "dailyQuote"
    static let lastQuoteDateKey = "lastQuoteDate"
    
    // MARK: - Habit Categories
    static let habitCategories = [
        "Health & Fitness",
        "Productivity",
        "Mindfulness",
        "Learning",
        "Creativity",
        "Social",
        "Finance",
        "Other"
    ]
    
    // MARK: - Motivational Quotes
    static let motivationalQuotes = [
        "The only way to do great work is to love what you do.",
        "Believe you can and you're halfway there.",
        "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "The future belongs to those who believe in the beauty of their dreams.",
        "It does not matter how slowly you go as long as you do not stop.",
        "Everything you've ever wanted is on the other side of fear.",
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine.",
        "I learned that courage was not the absence of fear, but the triumph over it.",
        "Only in the darkness can you see the stars.",
        "Great things never come from comfort zones.",
        "Don't watch the clock; do what it does. Keep going.",
        "The harder you work for something, the greater you'll feel when you achieve it.",
        "Dream bigger. Do bigger.",
        "Don't stop when you're tired. Stop when you're done.",
        "Wake up with determination. Go to bed with satisfaction.",
        "Do something today that your future self will thank you for.",
        "Little things make big days.",
        "It's going to be hard, but hard does not mean impossible.",
        "Don't wait for opportunity. Create it.",
        "Sometimes we're tested not to show our weaknesses, but to discover our strengths.",
        "The key to success is to focus on goals, not obstacles.",
        "Dream it. Believe it. Build it.",
        "Success doesn't just find you. You have to go out and get it.",
        "The harder the battle, the sweeter the victory.",
        "Your limitation—it's only your imagination.",
        "Push yourself, because no one else is going to do it for you.",
        "Sometimes later becomes never. Do it now.",
        "Great things never come from comfort zones.",
        "Dream it. Wish it. Do it.",
        "Success is the sum of small efforts repeated day in and day out."
    ]
    
    // MARK: - Onboarding
    static let onboardingSteps = [
        OnboardingStep(
            title: "Welcome to Thriveon",
            description: "Your personal companion for building better habits and achieving your goals",
            systemImage: "sparkles"
        ),
        OnboardingStep(
            title: "Track Your Habits",
            description: "Create custom habits and track your progress with beautiful visualizations",
            systemImage: "checkmark.circle.fill"
        ),
        OnboardingStep(
            title: "Get Insights",
            description: "Understand your patterns with powerful analytics and personalized recommendations",
            systemImage: "chart.bar.fill"
        ),
        OnboardingStep(
            title: "Stay Motivated",
            description: "Receive daily inspiration and celebrate your achievements along the way",
            systemImage: "flame.fill"
        )
    ]
}

struct OnboardingStep {
    let title: String
    let description: String
    let systemImage: String
}
