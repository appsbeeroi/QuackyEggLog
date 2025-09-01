import SwiftUI
import SwipeActions

struct DuckFeedingCellView: View {
    
    let feeding: DuckFeeding
    
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            HStack {
                VStack {
                    Text(feeding.type)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.brust(with: 20))
                        .foregroundStyle(.black)
                    
                    Text(feeding.date.formatted(.dateTime.year().month(.twoDigits).day()))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.brust(with: 16))
                        .foregroundStyle(.baseDarkGray)
                }
                
                StrokeText(feeding.quantity + " KG", fontSize: 35)
            }
            .frame(height: 80)
            .padding(.horizontal, 6)
            .background(.white)
            .cornerRadius(18)
        } trailingActions: { context in
            HStack(spacing: 4) {
                Button {
                    context.state.wrappedValue = .closed
                    editAction()
                } label: {
                    Image(.Images.Buttons.edit)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
                }
                
                Button {
                    context.state.wrappedValue = .closed
                    removeAction()
                } label: {
                    Image(.Images.Buttons.remove)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 42, height: 42)
                }
            }
        }
        .swipeMinimumDistance(30)
    }
}
