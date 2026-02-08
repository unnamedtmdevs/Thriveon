//
//  MainView.swift
//  Thriveon
//
//  Created by Simon Bakhanets on 08.02.2026.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = DashboardViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack {
            Theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                content
                customTabBar
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedTab {
        case 0:
            DashboardView(viewModel: viewModel)
        case 1:
            NavigationView {
                HabitsView(viewModel: viewModel)
            }
        case 2:
            AnalyticsView(viewModel: viewModel)
        case 3:
            SettingsView(viewModel: viewModel)
        default:
            DashboardView(viewModel: viewModel)
        }
    }
    
    private var customTabBar: some View {
        HStack(spacing: 0) {
            tabButton(index: 0, icon: "house.fill", title: "Home")
            tabButton(index: 1, icon: "list.bullet", title: "Habits")
            tabButton(index: 2, icon: "chart.bar.fill", title: "Analytics")
            tabButton(index: 3, icon: "gearshape.fill", title: "Settings")
        }
        .padding(.vertical, Theme.spacingM)
        .background(Theme.cardBackground)
    }
    
    private func tabButton(index: Int, icon: String, title: String) -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = index
            }
        }) {
            VStack(spacing: Theme.spacingXS) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == index ? Theme.accent : Theme.textSecondary)
                
                Text(title)
                    .font(Theme.caption())
                    .foregroundColor(selectedTab == index ? Theme.accent : Theme.textSecondary)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview("iPhone SE") {
    MainView()
        .previewDevice(PreviewDevices.iPhoneSE)
}

#Preview("iPhone 15 Pro Max") {
    MainView()
        .previewDevice(PreviewDevices.iPhone15ProMax)
}

#Preview("iPad Air 11-inch") {
    MainView()
        .previewDevice(PreviewDevices.iPadAir11)
}
