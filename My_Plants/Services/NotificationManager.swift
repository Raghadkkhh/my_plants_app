//
//  NotificationManager.swift
//  My_Plants
//
//  Created by Raghad Alsnaie on 15/11/2026.
//

import UserNotifications

final class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()

    private let center = UNUserNotificationCenter.current()
    private let testMode = false

    private override init() {
        super.init()
        center.delegate = self
    }

    func requestPermission() {
        center.requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    func schedule(for plant: PlantsData) {
        let id = plant.id.uuidString
        let seconds: TimeInterval = testMode ? 60 : TimeInterval(plant.plantWateringDays.days * 86400)

        center.requestAuthorization(options: [.alert, .sound]) { [center] granted, _ in
            guard granted else { return }

            let content = UNMutableNotificationContent()
            content.title = "Planto"
            content.body = "Hey! let's water your plant"
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
            let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
            center.add(request)
        }
    }

    func cancel(for plant: PlantsData) {
        center.removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}
