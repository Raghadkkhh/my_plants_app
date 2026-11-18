//
//  MyPlantsView.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI
import SwiftData

struct MyPlantsView: View {
    @Environment(\.modelContext) private var context
    @Query private var plants: [PlantsData]
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

            addButton
        }
        .onAppear {
            viewModel.resetIfNeeded(plants)
        }
        .sheet(isPresented: $viewModel.showingAddSheet) {
            SetReminderView(viewModel: viewModel)
        }
        .sheet(item: $viewModel.plantToEdit) { plant in
            SetReminderView(viewModel: viewModel, plant: plant)
        }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state(for: plants) {
        case .empty:
            Text("No reminders set yet..")
                .font(.headline)
                .foregroundStyle(Color.appGray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .allDone:
            VStack(spacing: 0) {
                Image("Plant_wink_pic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 164, height: 200)
                    .padding(.top, 119)

                Text("All Done! 🎉")
                    .font(.title3.bold())
                    .foregroundStyle(.white)
                    .padding(.top, 60)

                Text("All Reminders Completed")
                    .font(.subheadline)
                    .foregroundStyle(Color.appGray)
                    .padding(.top, 14)
            }

        case .list:
            VStack(spacing: 0) {
                Text(viewModel.message(plants))
                    .font(.subheadline)
                    .foregroundStyle(.white)
                    .padding(.top, 34)

                progressBar
                    .frame(height: 10)
                    .padding(.horizontal, 16)
                    .padding(.top, 15)

                plantsList
                    .padding(.top, 60)
            }
        }
    }

    private var progressBar: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.cardBackground)

                Capsule()
                    .fill(Color.appGreen)
                    .frame(width: geometry.size.width * viewModel.progress(plants))
            }
        }
        .animation(.easeInOut, value: viewModel.progress(plants))
    }

    private var plantsList: some View {
        List {
            ForEach(viewModel.sorted(plants)) { plant in
                PlantRowView(plant: plant) {
                    withAnimation {
                        viewModel.toggleWatered(plant)
                    }
                }
                .onTapGesture {
                    viewModel.plantToEdit = plant
                }
                .listRowBackground(Color.black)
                .listRowSeparatorTint(Color.cardBackground)
                .listRowInsets(EdgeInsets(top: 13, leading: 20, bottom: 13, trailing: 20))
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button(role: .destructive) {
                        viewModel.delete(plant, context: context)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }

    private var addButton: some View {
        Button {
            viewModel.showingAddSheet = true
        } label: {
            Image(systemName: "plus")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .glassEffect(.regular.tint(Color.appGreen.opacity(0.8)).interactive(), in: Circle())
        }
        .buttonStyle(.plain)
        .padding(24)
    }
}
