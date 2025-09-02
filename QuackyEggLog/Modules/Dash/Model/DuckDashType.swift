import RealmSwift

enum DuckDashType: String, Codable, PersistableEnum {
    case fact = "FACT"
    case advice = "ADVICE"
}
