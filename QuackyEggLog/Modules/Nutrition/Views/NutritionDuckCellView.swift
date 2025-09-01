import SwiftUI
import SwipeActions

struct NutritionDuckCellView: View {
    
    let duck: Duck
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            HStack(spacing: 5) {
                VStack(spacing: 5) {
                    HStack {
                        if let image = duck.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 93, height: 93)
                                .clipped()
                                .cornerRadius(16)
                        }
                        
                        Spacer()
                        
                        VStack {
                            Text(duck.breed)
                                .frame(height: 40)
                                .padding(.horizontal, 14)
                                .font(.brust(with: 13))
                                .foregroundStyle(.baseYellow)
                                .cornerRadius(13)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 13)
                                        .stroke(.baseYellow, lineWidth: 3)
                                }
                        }
                        .frame(maxHeight: .infinity, alignment: .topTrailing)
                    }
                    
                    Text(duck.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.brust(with: 25))
                        .foregroundStyle(.black)
                }
                
                VStack {
                    Image(systemName: "arrowshape.right.circle.fill")
                        .font(.system(size: 30, weight: .medium))
                        .foregroundStyle(.baseYellow)
                }
                .frame(maxHeight: .infinity)
            }
            .frame(height: 140)
            .padding(10)
            .background(.white)
            .cornerRadius(18)
        }
        trailingActions: { context in
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
