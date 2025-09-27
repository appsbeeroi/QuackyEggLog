import Foundation

struct DuckFeedingObject: Identifiable, Codable {
    var id: UUID
    var date: Date
    var type: String
    var quontity: String
    
    init(from model: DuckFeeding) {
        self.id = model.id
        self.date = model.date
        self.type = model.type
        self.quontity = model.quantity
    }
}
