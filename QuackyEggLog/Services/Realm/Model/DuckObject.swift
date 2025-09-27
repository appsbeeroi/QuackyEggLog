import Foundation

final class DuckObject: Identifiable, Codable {
    var id: UUID
    var imagePath: String
    var name: String
    var breed: String
    var age: String
    var weight: String
    var features: String
    var feedings: [DuckFeedingObject]
    var reminders: [ReminderObject]
    var specificReminderDate: Date
    var events: [EventObject]
    
    init(from model: Duck, and imagePath: String) {
        self.id = model.id
        self.imagePath = imagePath
        self.name = model.name
        self.breed = model.breed
        self.age = model.age
        self.weight = model.weight
        self.features = model.features
        self.specificReminderDate = model.specificReminderDate
        self.feedings = model.feedings.map { DuckFeedingObject(from: $0)}
        self.reminders = model.reminders.map { ReminderObject(from: $0 )}
        self.events = model.events.map { EventObject(from: $0 )}
    }
}
