import RealmSwift

enum ReminderType: String, Identifiable, CaseIterable, Equatable, PersistableEnum {
    var id: Self { self }
    
    case care
    case vaccine
    
    var title: String {
        switch self {
            case .care:
                "CARE"
            case .vaccine:
                "VACCINE"
        }
    }
}
