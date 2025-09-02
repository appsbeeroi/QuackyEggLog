import SwiftUI

struct EventTypeCell: View {
    
    let type: EventType
    
    @Binding var selectedEventType: EventType?
    
    var body: some View {
        Button {
            selectedEventType = type
        } label: {
            VStack {
                Image(type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                
                Text(type.title)
                    .font(.brust(with: 12))
                    .foregroundStyle(selectedEventType == type ? .baseYellow : .black)
            }
            .frame(height: 80)
            .padding(.horizontal, 16)
            .background(.white)
            .cornerRadius(18)
            .overlay {
                if selectedEventType == type {
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.baseYellow, lineWidth: 4)
                }
            }
        }
    }
}

#Preview {
    EventTypeCell(type: .diseases, selectedEventType: .constant(nil))
}
