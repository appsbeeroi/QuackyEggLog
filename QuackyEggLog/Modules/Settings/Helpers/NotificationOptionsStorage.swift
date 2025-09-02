import Foundation

struct NotificationOptionsStorage {
    private static let key = "notification_options"
    private static let defaults = UserDefaults.standard

    static var saved: [NotificationOptions] {
        get {
            guard let data = defaults.data(forKey: key),
                  let decoded = try? JSONDecoder().decode([NotificationOptions].self, from: data)
            else { return [] }
            return decoded
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                defaults.set(encoded, forKey: key)
            }
        }
    }
}

