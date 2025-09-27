import Foundation

struct DuckDashObject: Identifiable, Codable {
    var uuid: UUID
    var id: String
    var type: DuckDashType
    var text: String
    var isFavorite: Bool
    
    init(from model: DuckDashItem) {
        self.uuid = model.stableUUID
        self.id = model.id
        self.type = model.type
        self.text = model.text
        self.isFavorite = model.isFavorite
    }
}
