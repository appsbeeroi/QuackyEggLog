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
    }
}
