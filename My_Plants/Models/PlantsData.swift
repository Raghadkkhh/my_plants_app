//
//  PlantsData.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftData
import Foundation

@Model
final class PlantsData {
    @Attribute(.unique) var id: UUID
    var plantName: String
    var plantRoom: Room
    var plantLight: LightLevel
    var plantWateringDays: WateringFrequency
    var plantWaterAmount: WaterAmount
    var plantIsWatered: Bool
    var lastWateredDate: Date?

    init(
        id: UUID = UUID(),
        plantName: String,
        plantRoom: Room,
        plantLight: LightLevel,
        plantWateringDays: WateringFrequency,
        plantWaterAmount: WaterAmount,
        plantIsWatered: Bool = false,
        lastWateredDate: Date? = nil
    ) {
        self.id = id
        self.plantName = plantName
        self.plantRoom = plantRoom
        self.plantLight = plantLight
        self.plantWateringDays = plantWateringDays
        self.plantWaterAmount = plantWaterAmount
        self.plantIsWatered = plantIsWatered
        self.lastWateredDate = lastWateredDate
    }
}
