import Foundation
import RealmSwift

final class DuckFeedingObject: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var date: Date
    @Persisted var type: String
    @Persisted var quontity: String
    
    convenience init(from model: DuckFeeding) {
        self.init()
        self.id = model.id
        self.date = model.date
        self.type = model.type
        self.quontity = model.quantity
    }
}
