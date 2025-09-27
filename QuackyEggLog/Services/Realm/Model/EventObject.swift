import Foundation

struct EventObject: Identifiable, Codable {
    var id: UUID
    var eventType: EventType
    var eventDate: Date
    
    init(from model: Event) {
        self.id = model.id
        self.eventType = model.eventType ?? .diseases
        self.eventDate = model.eventDate
    }
}
