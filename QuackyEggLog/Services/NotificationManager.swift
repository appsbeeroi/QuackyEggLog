import UserNotifications
import UIKit

final class NotificationManager {
    
    static let shared = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private init() {}

    var authorizationStatus: UNAuthorizationStatus {
        get async {
            let settings = await notificationCenter.notificationSettings()
            return settings.authorizationStatus
        }
    }

    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Failed to request notification permission: \(error)")
            } else {
                print(granted ? "✅ Notification permission granted" : "🚫 Notification permission denied")
            }
        }
    }

    func scheduleDailyNotification(at hour: Int = 12, minute: Int = 0) {
        let content = UNMutableNotificationContent()
        content.title = "Time to play!"
        content.body = "Joker is waiting — let's go!"
        content.sound = .default

        var triggerTime = DateComponents()
        triggerTime.hour = hour
        triggerTime.minute = minute

        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerTime, repeats: true)

        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request) { error in
            if let error = error {
                print("❌ Failed to schedule daily notification: \(error)")
            } else {
                print("✅ Daily notification set for \(hour):\(String(format: "%02d", minute))")
            }
        }
    }

    func clearAllScheduledNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("🧹 Cleared all scheduled notifications")
    }
}
