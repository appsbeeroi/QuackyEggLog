enum NotificationOptions: String, Codable, CaseIterable, Identifiable, Equatable {
    var id: Self { self }

    case feeding
    case care
    case vaccination

    var title: String {
        switch self {
        case .feeding: "Feeding"
        case .care: "Care"
        case .vaccination: "Vaccination"
        }
    }
}
