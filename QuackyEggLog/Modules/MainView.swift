import SwiftUI

struct MainView: View {
    
    @State private var isShowMainFlow = false
    
    var body: some View {
        if isShowMainFlow {
            TabBarView()
                .transition(.opacity)
        } else {
            SplashScreen(isShowMainFlow: $isShowMainFlow)
        }
    }
}

#Preview {
    MainView()
}
