//
//  ContentView.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var viewModel = PlantsViewModel()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                Text("My Plants 🌱")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 12)

                Rectangle()
                    .fill(Color.lineGray)
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)

                if hasSeenOnboarding {
                    MyPlantsView(viewModel: viewModel)
                } else {
                    OnboardingView(viewModel: viewModel) {
                        hasSeenOnboarding = true
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
        .modelContainer(for: PlantsData.self, inMemory: true)
}
