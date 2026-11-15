//
//  OnboardingView.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI

struct OnboardingView: View {
    var viewModel: PlantsViewModel
    var onFinish: () -> Void
    @State private var showingSheet = false

    var body: some View {
        VStack(spacing: 0) {
            Image("Plant_pic")
                .resizable()
                .scaledToFit()
                .frame(width: 164, height: 200)
                .padding(.top, 77)

            Text("Start your plant journey!")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .padding(.top, 37)

            Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                .font(.footnote)
                .foregroundStyle(Color.appGray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .padding(.top, 25)

            Button {
                showingSheet = true
            } label: {
                Text("Set Plant Reminder")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .glassEffect(.regular.tint(Color.appGreen.opacity(0.8)).interactive(), in: Capsule())
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 60)
            .padding(.top, 105)

            Spacer()
        }
        .sheet(isPresented: $showingSheet, onDismiss: onFinish) {
            SetReminderView(viewModel: viewModel)
        }
    }
}
