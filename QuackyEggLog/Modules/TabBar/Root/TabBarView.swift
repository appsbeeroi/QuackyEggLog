import SwiftUI

struct TabBarView: View {
    
    @State private var selection: TabBarPage = .nutrition
    
    @State private var isShowTabBar = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                NutritionView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarPage.nutrition)
                
                StatisticsView()
                    .tag(TabBarPage.statistics)
                
                DashView(isShowTabBar: $isShowTabBar)
                    .tag(TabBarPage.dash)
                
                SettingsView(isShowTabBar: $isShowTabBar)
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


