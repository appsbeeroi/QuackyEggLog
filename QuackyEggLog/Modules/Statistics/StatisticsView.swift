import SwiftUI

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
