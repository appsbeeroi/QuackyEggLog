import Foundation

struct DuckDashItem: Identifiable, Codable, Equatable {
    let id: String
    let type: DuckDashType
    let text: String
    var isFavorite: Bool

    var stableUUID: UUID {
        let hash = "\(id)-duckdash".hashValue
        let uuidString = String(format: "%08X-%04X-%04X-%04X-%012X",
                                hash & 0xFFFFFFFF,
                                (hash >> 32) & 0xFFFF,
                                (hash >> 48) & 0xFFFF,
                                (hash >> 64) & 0xFFFF,
                                (hash >> 80) & 0xFFFFFFFFFFFF)
        return UUID(uuidString: uuidString) ?? UUID()
    }
    
    init(
        id: String,
        type: DuckDashType,
        text: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.type = type
        self.text = text
        self.isFavorite = isFavorite
    }
    
    init() {
        self.id = "0"
        self.type = .advice
        self.text = ""
        self.isFavorite = false
    }
    
    init(from object: DuckDashObject) {
        self.id = object.id
        self.type = object.type
        self.text = object.text
        self.isFavorite = object.isFavorite
    }
}
