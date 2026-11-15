//
//  PlantRowView.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI

struct PlantRowView: View {
    let plant: PlantsData
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            Button(action: onToggle) {
                Image(systemName: plant.plantIsWatered ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(plant.plantIsWatered ? Color.appGreen : .gray)
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                    Text("in \(plant.plantRoom.rawValue)")
                }
                .font(.caption)
                .foregroundStyle(Color.appGray)

                Text(plant.plantName)
                    .font(.title2)
                    .foregroundStyle(plant.plantIsWatered ? .gray : .white)

                HStack(spacing: 8) {
                    tag(plant.plantLight.icon, plant.plantLight.rawValue, Color.tagText)
                    tag("drop", plant.plantWaterAmount.rawValue, Color.waterTagText)
                }
                .opacity(plant.plantIsWatered ? 0.5 : 1)
            }

            Spacer()
        }
        .contentShape(Rectangle())
    }

    private func tag(_ icon: String, _ text: String, _ color: Color) -> some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
            Text(text)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .font(.caption)
        .foregroundStyle(color)
        .frame(width: 89, height: 23)
        .background(Color.cardBackground, in: RoundedRectangle(cornerRadius: 8))
    }
}
