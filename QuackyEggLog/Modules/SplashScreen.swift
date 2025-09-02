import SwiftUI

struct SplashScreen: View {
    
    @Binding var isShowMainFlow: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            Text("QuackyEgg\nLog")
                .font(.brust(with: 70))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
                .opacity(isAnimating ? 1 : 0)
        }
        .animation(.easeInOut(duration: 3), value: isAnimating)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isAnimating = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    withAnimation {
                        isShowMainFlow = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isShowMainFlow: .constant(false))
}
