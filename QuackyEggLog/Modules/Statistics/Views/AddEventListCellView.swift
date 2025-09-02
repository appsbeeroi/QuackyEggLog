import SwiftUI

struct AddEventListCellView: View {
    
    let duck: Duck
    
    @Binding var selectedDuck: Duck?
    
    var body: some View {
        Button {
            selectedDuck = duck
        } label: {
            HStack {
                VStack {
                    HStack {
                        if let image = duck.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 68, height: 68)
                                .clipped()
                                .cornerRadius(16)
                        }
                        
                        VStack {
                            Text(duck.breed)
                                .frame(height: 34)
                                .padding(.horizontal, 13)
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
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(duck.name)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.brust(with: 25))
                        .foregroundStyle(.black)
                }
                
                Circle()
                    .stroke(.baseYellow, lineWidth: (selectedDuck?.id ?? UUID()) == duck.id ? 10 : 1)
                    .frame(width: 30, height: 30)
            }
            .frame(height: 110)
            .padding(10)
            .background(.white)
            .cornerRadius(18)
        }
    }
}

#Preview {
    ZStack {
        Image(.Images.background)
            .scaleToFillAndCropp()
        
        AddEventListCellView(duck: Duck(isReal: false), selectedDuck: .constant(Duck(isReal: false)))
            .padding()
    }
}
