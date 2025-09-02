import SwiftUI

struct NotificationOptionCellView: View {
    
    let option: NotificationOptions
    
    @Binding var notificationOptions: [NotificationOptions]
    
    @State private var isOn = false
    
    var body: some View {
        HStack {
            Text(option.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(.black)
            
            Toggle(isOn: $isOn) {}
                .labelsHidden()
                .tint(isOn ? .baseYellow : .baseDarkGray)
        }
        .frame(minHeight: 60)
        .padding(.horizontal, 10)
        .background(.white)
        .overlay(alignment: .bottom) {
            if option != .vaccination {
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.baseDarkGray.opacity(0.3))
            }
        }
        .onAppear {
            isOn = notificationOptions.contains(option)
        }
        .onChange(of: isOn) { isOn in
            if isOn && !notificationOptions.contains(option) {
                notificationOptions.append(option)
            } else {
                guard let index = notificationOptions.firstIndex(where: { $0 == option }) else { return }
                notificationOptions.remove(at: index)
            }
        }
    }
}
