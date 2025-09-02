import SwiftUI

struct SettingsCell: View {
    
    let type: SettingsType
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(type.title)
                    .frame(height: 66)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.brust(with: 25))
                    .foregroundStyle(.black)
                
                Image(systemName: "arrowshape.right.circle.fill")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(.baseYellow)
            }
            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(18)
        }
    }
}

