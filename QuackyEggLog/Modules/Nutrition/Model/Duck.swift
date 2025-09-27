import UIKit

struct Duck: Identifiable, Equatable {
    let id: UUID
    var image: UIImage?
    var name: String
    var breed: String
    var age: String
    var weight: String
    var features: String
    var feedings: [DuckFeeding]
    var reminders: [Reminder]
    var specificReminderDate: Date
    var events: [Event]
    
    var isUnlock: Bool {
        image != nil && name != "" && breed != "" && age != "" && weight != "" && features != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.image = isReal ? nil : UIImage()
        self.name = isReal ? "" : "Name"
        self.breed = isReal ? "" : "Breed"
        self.age = isReal ? "" : "12"
        self.weight = isReal ? "" : "33"
        self.features = isReal ? "" : "Features"
        self.feedings = isReal ? [] : [DuckFeeding(isReal: false)]
        self.reminders = isReal ? [] : [Reminder(isReal: false)]
        self.specificReminderDate = Date()
        self.events = []
    }
    
    init(from object: DuckObject, and image: UIImage) {
        self.id = object.id
        self.image = image
        self.name = object.name
        self.breed = object.breed
        self.age = object.age
        self.weight = object.weight
        self.features = object.features
        self.feedings = object.feedings.map { DuckFeeding(from: $0) }
        self.reminders = object.reminders.map { Reminder(from: $0) }
        self.specificReminderDate = object.specificReminderDate
        self.events = object.events.map { Event(from: $0) }
    }
}


import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private var lastPermissionCheck: Date?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize(AppConstants.oneSignalAppID, withLaunchOptions: launchOptions)
        
        UNUserNotificationCenter.current().delegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleTrackingAction),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        return true
    }
    
    @objc private func handleTrackingAction() {
        if UIApplication.shared.applicationState == .active {
            let now = Date()
            if let last = lastPermissionCheck, now.timeIntervalSince(last) < 2 {
                return
            }
            lastPermissionCheck = now
            NotificationCenter.default.post(name: .checkTrackingPermission, object: nil)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}
