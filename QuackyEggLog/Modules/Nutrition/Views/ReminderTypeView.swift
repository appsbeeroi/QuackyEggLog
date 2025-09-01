import SwiftUI

struct ReminderTypeView: View {
    
    let type: ReminderType
    
    @Binding var selectedType: ReminderType?
    
    var body: some View {
        Button {
            selectedType = type
        } label: {
            Text(type.title)
                .font(.brust(with: 16))
                .frame(minHeight: 40)
                .padding(.horizontal, 22)
                .background(.white)
                .foregroundStyle(selectedType == type ? .baseYellow : .black)
                .cornerRadius(13)
                .lineLimit(1)
                .overlay {
                    if selectedType == type {
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(.baseYellow, lineWidth: 3)
                    }
                }
        }
    }
}
