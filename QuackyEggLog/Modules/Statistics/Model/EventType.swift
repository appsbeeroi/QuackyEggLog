import RealmSwift

enum EventType: String, Identifiable, CaseIterable, PersistableEnum, Equatable {
    var id: Self { self }
    
    case vaccinations
    case molting
    case diseases
    
    var title: String {
        switch self {
            case .vaccinations:
                "VACCINATIONS"
            case .molting:
                "MOTLING"
            case .diseases:
                "DISEASES"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .vaccinations:
                    .Images.Statistics.vaccination
            case .molting:
                    .Images.Statistics.molting
            case .diseases:
                    .Images.Statistics.diseases
        }
    }
}
