import Foundation
import RealmSwift

final class ReminderObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var type: ReminderType
    @Persisted var frequency: FrequencyType
    @Persisted var comment: String
    
    convenience init(from model: Reminder) {
        self.init()
        self.id = model.id
        self.type = model.type ?? .care
        self.frequency = model.frequency ?? .daily
        self.comment = model.comment
    }
}
