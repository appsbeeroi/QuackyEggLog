import SwiftUI

struct DuckDashCellView: View {
    
    let item: DuckDashItem
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(item.type.rawValue)
                    .frame(height: 33)
                    .padding(.horizontal, 18)
                    .font(.brust(with: 16))
                    .foregroundStyle(.baseYellow)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(.baseYellow, lineWidth: 3)
                    }
                
                Spacer()
                
                Button {
                    action()
                } label: {
                    Image(item.isFavorite ? .Images.Buttons.like : .Images.Buttons.unlike)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
                }
            }
           
            Text(item.text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 18))
                .foregroundStyle(.black)
                .multilineTextAlignment(.leading)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 13)
        .background(.white)
        .cornerRadius(18)
    }
}
