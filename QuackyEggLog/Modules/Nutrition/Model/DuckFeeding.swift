import Foundation

struct DuckFeeding: Identifiable, Equatable {
    var id: UUID
    var date: Date
    var type: String
    var quantity: String
    
    var isUnlock: Bool {
        type != "" && quantity != ""
    }
    
    init(isReal: Bool) {
        self.id = UUID()
        self.date = Date()
        self.type = isReal ? "" : "Food"
        self.quantity = isReal ? "" : "1"
    }
}
