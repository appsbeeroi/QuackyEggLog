import RealmSwift
import Foundation

final class DuckObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var imagePath: String
    @Persisted var name: String
    @Persisted var breed: String
    @Persisted var age: String
    @Persisted var weight: String
    @Persisted var features: String
    @Persisted var feedings = List<DuckFeedingObject>()
    @Persisted var reminders = List<ReminderObject>()
    @Persisted var specificReminderDate: Date
    
    convenience init(from model: Duck, and imagePath: String) {
        self.init()
        self.id = model.id
        self.imagePath = imagePath
        self.name = model.name
        self.breed = model.breed
        self.age = model.age
        self.weight = model.weight
        self.features = model.features
        self.specificReminderDate = model.specificReminderDate
        
        model.feedings.forEach {
            self.feedings.append(DuckFeedingObject(from: $0))
        }
        
        model.reminders.forEach {
            self.reminders.append(ReminderObject(from: $0))
        }
    }
}
