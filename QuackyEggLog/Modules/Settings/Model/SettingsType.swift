enum SettingsType: Identifiable, CaseIterable {
    var id: Self { self }
    
    case notifications
    case privacy
    case developer
    
    var title: String {
        switch self {
            case .notifications:
                "NOTIFICATIONS"
            case .privacy:
                "PRIVACY POLICY"
            case .developer:
                "DEVELOPER"
        }
    }
    
    var path: String {
        switch self {
            case .notifications:
                ""
            case .privacy:
                "https://sites.google.com/view/quackyegg-log/privacy-policy"
            case .developer:
                "https://sites.google.com/view/quackyegg-log/home"
        }
    }
}
