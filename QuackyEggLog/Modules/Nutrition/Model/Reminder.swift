import Foundation

struct Reminder: Identifiable, Equatable {
    let id: UUID
    var type: ReminderType?
    var frequency: FrequencyType?
    var comment: String
    
    var isUnlock: Bool {
        type != nil && frequency != nil && comment != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.type = isReal ? nil : .care
        self.frequency = isReal ? nil : .every3days
        self.comment = isReal ? "" : "This is a test reminder"
    }
    
    init(from object: ReminderObject) {
        self.id = object.id
        self.type = object.type
        self.frequency = object.frequency
        self.comment = object.comment
    }
}

