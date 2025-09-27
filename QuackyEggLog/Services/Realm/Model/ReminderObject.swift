import Foundation

struct ReminderObject: Identifiable, Codable {
    var id: UUID
    var type: ReminderType
    var frequency: FrequencyType
    var comment: String
    
    init(from model: Reminder) {
        self.id = model.id
        self.type = model.type ?? .care
        self.frequency = model.frequency ?? .daily
        self.comment = model.comment
    }
}
