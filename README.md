# Planto 🌱

Planto is an iOS app that helps you take care of your plants. Add all your plants in one place and get a reminder when it's time to water each one.

# Description

Planto is a plant care reminder app built with Swift and SwiftUI. When you open it for the first time, a welcome screen invites you to set your first plant reminder. For each plant you choose its name, room, light, watering days, and water amount. The home screen then shows your plants and tracks your daily watering progress with a progress bar. When every plant is watered, an "All Done" screen appears. The app is dark mode only, uses Liquid Glass buttons, and follows the MVVM architecture with SwiftData for storage.

# Main Features

- Add a plant with its name, room, light, watering days, and water amount
- See all your plants in one list with the room, light, and water amount for each
- Mark a plant as watered and track your progress with a progress bar
- Watered plants move to the bottom of the list
- Edit or delete a plant
- Get a local notification when it's time to water each plant


# Getting Started

## Dependencies

- macOS with Xcode 26 or later
- iOS 26.0 or later (required for Liquid Glass)
- Swift 6 and SwiftUI

## Installing

- Clone the repository:

```bash
git clone https://github.com/Raghadkkhh/my_plants_app
```

- Open (My_Plants.xcodeproj) in Xcode
- Make sure the app images (Plant_pic) and (Plant_wink_pic) are inside (Assets.xcassets)

## Executing program

- Select an iPhone simulator running iOS 26 (or a real device)
- Press ⌘R to build and run
- Tap Allow when the app asks for notification permission
- Tap Set Plant Reminder, fill in the plant details, and tap ✓

# Technologies Used

- Swift
- SwiftUI
- SwiftData
- MVVM architecture
- UserNotifications (local notifications)
- Liquid Glass (iOS 26)

Add your screenshots here.
