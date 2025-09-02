import RealmSwift
import Foundation

final class EventObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var eventType: EventType
    @Persisted var eventDate: Date
    
    convenience init(from model: Event) {
        self.init()
        self.id = model.id
        self.eventType = model.eventType ?? .diseases
        self.eventDate = model.eventDate
    }
}
