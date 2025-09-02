import Foundation

struct Event: Identifiable, Equatable {
    let id: UUID
    var eventType: EventType?
    var eventDate: Date
    
    var isUnlock: Bool {
        eventType != nil
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.eventType = isReal ? nil : .diseases
        self.eventDate = Date()
    }
    
    init(from object: EventObject) {
        self.id = object.id
        self.eventType = object.eventType
        self.eventDate = object.eventDate
    }
}

