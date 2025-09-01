import Foundation
import RealmSwift

enum FrequencyType: String, Identifiable, Equatable, PersistableEnum {
    var id: Self { self }
    
    case daily
    case every3days
    case everyWeek
    case specificDates
    
    var title: String {
        switch self {
            case .daily:
                "DAILY"
            case .every3days:
                "EVERY 3 DAYS"
            case .everyWeek:
                "EVERY WEEK"
            case .specificDates:
                "SPECIFIC DATE(S)"
        }
    }
}
