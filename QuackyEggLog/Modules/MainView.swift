import SwiftUI

struct MainView: View {
    
    @State private var isShowMainFlow = false
    
    var body: some View {
        if isShowMainFlow {
            TabBarView()
        } else {
            SplashScreen()
        }
    }
}

#Preview {
    MainView()
}
