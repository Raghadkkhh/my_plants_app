//
//  My_PlantsApp.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import SwiftUI
import SwiftData

@main
struct My_PlantsApp: App {
    init() {
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: PlantsData.self)
    }
}
//
