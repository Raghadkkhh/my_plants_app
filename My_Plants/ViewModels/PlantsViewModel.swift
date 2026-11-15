//
//  PlantsViewModel.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI
import SwiftData

enum PlantsScreenState {
    case empty
    case list
    case allDone
}

@Observable
final class PlantsViewModel {
    var showingAddSheet = false
    var plantToEdit: PlantsData?

    func state(for plants: [PlantsData]) -> PlantsScreenState {
        if plants.isEmpty { return .empty }
        if plants.allSatisfy({ $0.plantIsWatered }) { return .allDone }
        return .list
    }

    func sorted(_ plants: [PlantsData]) -> [PlantsData] {
        plants.filter { !$0.plantIsWatered } + plants.filter { $0.plantIsWatered }
    }

    func wateredCount(_ plants: [PlantsData]) -> Int {
        plants.filter { $0.plantIsWatered }.count
    }

    func progress(_ plants: [PlantsData]) -> Double {
        plants.isEmpty ? 0 : Double(wateredCount(plants)) / Double(plants.count)
    }

    func message(_ plants: [PlantsData]) -> String {
        let count = wateredCount(plants)
        if count == 0 { return "Your plants are waiting for a sip 💦" }
        return "\(count) of your plants feel loved today ✨"
    }

    func toggleWatered(_ plant: PlantsData) {
        plant.plantIsWatered.toggle()
        plant.lastWateredDate = plant.plantIsWatered ? Date() : nil
    }

    func resetIfNeeded(_ plants: [PlantsData]) {
        for plant in plants where plant.plantIsWatered {
            guard let last = plant.lastWateredDate else { continue }
            let days = Calendar.current.dateComponents([.day], from: last, to: Date()).day ?? 0
            if days >= plant.plantWateringDays.days {
                plant.plantIsWatered = false
                plant.lastWateredDate = nil
            }
        }
    }

    func save(
        plant: PlantsData?,
        name: String,
        room: Room,
        light: LightLevel,
        frequency: WateringFrequency,
        amount: WaterAmount,
        context: ModelContext
    ) {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let target: PlantsData

        if let plant {
            plant.plantName = cleanName
            plant.plantRoom = room
            plant.plantLight = light
            plant.plantWateringDays = frequency
            plant.plantWaterAmount = amount
            target = plant
        } else {
            target = PlantsData(
                plantName: cleanName,
                plantRoom: room,
                plantLight: light,
                plantWateringDays: frequency,
                plantWaterAmount: amount
            )
            context.insert(target)
        }

        NotificationManager.shared.schedule(for: target)
    }

    func delete(_ plant: PlantsData, context: ModelContext) {
        NotificationManager.shared.cancel(for: plant)
        context.delete(plant)
    }
}
