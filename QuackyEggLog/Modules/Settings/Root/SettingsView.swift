import SwiftUI

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

#Preview {
    SettingsView()
}
