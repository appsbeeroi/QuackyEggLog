import SwiftUI

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

struct TabBarView: View {
    
    @State private var selection: TabBarPage = .nutrition
    
    @State private var isShowTabBar = false
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                NutritionView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarPage.nutrition)
                
                StatisticsView()
                    .tag(TabBarPage.statistics)
                
                DashView()
                    .tag(TabBarPage.dash)
                
                SettingsView()
                    .tag(TabBarPage.settings)
            }
            
            tabBarView
        }
    }
    
    private var tabBarView: some View {
        VStack {
            HStack {
                ForEach(TabBarPage.allCases) { page in
                    Button {
                        selection = page
                    } label: {
                        Image(page.icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                            .opacity(page == selection ? 1 : 0.5)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 40)
            .background(
                Image(.Images.wideWood)
                    .resizable()
                    .frame(height: 72)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 32)
            )
            .padding(.bottom, 24)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .opacity(isShowTabBar ? 1 : 0)
        .animation(.easeInOut, value: isShowTabBar)
    }
}

#Preview {
    TabBarView()
}



struct StatisticsView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                Text("Statistics")
                
                VStack(spacing: 16) {
                    navigationView
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private var navigationView: some View {
        Text("STATISTICS &\nPRODUCTIVITY")
            .font(.brust(with: 35))
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
            .lineLimit(2)
    }
}

struct DashView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                Text("Dash")
                
                VStack(spacing: 16) {
                    navigationView
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private var navigationView: some View {
        Text("DUCK DASH")
            .font(.brust(with: 35))
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
            .lineLimit(2)
    }
}

struct SettingsView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.Images.background)
                    .scaleToFillAndCropp()
                Text("Settings")
                
                VStack(spacing: 16) {
                    navigationView
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
    }
    
    private var navigationView: some View {
        Text("SETTINGS")
            .font(.brust(with: 35))
            .multilineTextAlignment(.center)
            .foregroundStyle(.black)
            .lineLimit(2)
    }
}
