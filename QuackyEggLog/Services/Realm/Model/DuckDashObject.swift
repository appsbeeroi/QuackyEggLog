import RealmSwift
import Foundation

final class DuckDashObject: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var uuid: UUID
    @Persisted var id: String
    @Persisted var type: DuckDashType
    @Persisted var text: String
    @Persisted var isFavorite: Bool
    
    convenience init(from model: DuckDashItem) {
        self.init()
        self.uuid = model.stableUUID
        self.id = model.id
        self.type = model.type
        self.text = model.text
        self.isFavorite = model.isFavorite
    }
}
