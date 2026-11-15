//
//  SetReminderView.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI
import SwiftData

struct SetReminderView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    var viewModel: PlantsViewModel
    var plant: PlantsData?

    @State private var name: String
    @State private var room: Room
    @State private var light: LightLevel
    @State private var frequency: WateringFrequency
    @State private var amount: WaterAmount

    init(viewModel: PlantsViewModel, plant: PlantsData? = nil) {
        self.viewModel = viewModel
        self.plant = plant
        _name = State(initialValue: plant?.plantName ?? "")
        _room = State(initialValue: plant?.plantRoom ?? .bedroom)
        _light = State(initialValue: plant?.plantLight ?? .fullSun)
        _frequency = State(initialValue: plant?.plantWateringDays ?? .everyDay)
        _amount = State(initialValue: plant?.plantWaterAmount ?? .small)
    }

    private var isNameEmpty: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            Color.sheetBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                nameField
                    .padding(.top, 40)

                card {
                    pickerRow("Room", "location", $room)
                    Divider()
                    pickerRow("Light", "sun.max", $light)
                }
                .padding(.top, 40)

                card {
                    pickerRow("Watering Days", "drop", $frequency)
                    Divider()
                    pickerRow("Water", "drop", $amount)
                }
                .padding(.top, 50)

                if plant != nil {
                    deleteButton
                        .padding(.top, 67.59)
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .preferredColorScheme(.dark)
    }

    private var header: some View {
        GlassEffectContainer {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.interactive(), in: Circle())
                }
                .buttonStyle(.plain)

                Spacer()

                Text("Set Reminder")
                    .font(.headline)
                    .foregroundStyle(.white)

                Spacer()

                Button {
                    viewModel.save(
                        plant: plant,
                        name: name,
                        room: room,
                        light: light,
                        frequency: frequency,
                        amount: amount,
                        context: context
                    )
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(width: 44, height: 44)
                        .glassEffect(.regular.tint(Color.appGreen.opacity(0.8)).interactive(), in: Circle())
                }
                .buttonStyle(.plain)
                .disabled(isNameEmpty)
            }
        }
    }

    private var nameField: some View {
        HStack(spacing: 8) {
            Text("Plant Name")
                .font(.system(size: 18))
                .foregroundStyle(.white)

            TextField("", text: $name, prompt: Text("Pothos").foregroundStyle(.gray))
                .font(.system(size: 18))
                .foregroundStyle(.white)
                .tint(Color.appGreen)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 16)
        .background(Color.cardBackground, in: Capsule())
    }

    private func card<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(spacing: 0) {
            content()
        }
        .padding(.horizontal, 16)
        .background(Color.cardBackground, in: RoundedRectangle(cornerRadius: 24))
    }

    private func pickerRow<T: CaseIterable & Hashable & RawRepresentable>(
        _ title: String,
        _ icon: String,
        _ selection: Binding<T>
    ) -> some View where T.RawValue == String {
        HStack {
            Label(title, systemImage: icon)
                .font(.system(size: 18))
                .foregroundStyle(.white)

            Spacer()

            Menu {
                Picker(title, selection: selection) {
                    ForEach(Array(T.allCases), id: \.self) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            } label: {
                HStack(spacing: 4) {
                    Text(selection.wrappedValue.rawValue)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.caption2)
                }
                .font(.system(size: 18))
                .foregroundStyle(Color.pickerValueGray)
            }
            .tint(Color.pickerValueGray)
        }
        .frame(height: 40)
    }

    private var deleteButton: some View {
        Button {
            if let plant {
                viewModel.delete(plant, context: context)
            }
            dismiss()
        } label: {
            Text("Delete Reminder")
                .font(.system(size: 18))
                .foregroundStyle(.red)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.cardBackground, in: Capsule())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 12)
    }
}
