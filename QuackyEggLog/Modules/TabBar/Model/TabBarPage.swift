enum TabBarPage: Identifiable, CaseIterable {
    var id: Self { self }
    
    case nutrition
    case statistics
    case dash
    case settings
    
    var icon: ImageResource {
        switch self {
            case .nutrition:
                    .Images.TabBar.nutrition
            case .statistics:
                    .Images.TabBar.statistics
            case .dash:
                    .Images.TabBar.dash
            case .settings:
                    .Images.TabBar.settings
        }
    }
}
