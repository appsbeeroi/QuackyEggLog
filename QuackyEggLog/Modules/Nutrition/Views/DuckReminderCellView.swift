import SwiftUI
import SwipeActions

struct DuckReminderCellView: View {
    
    let reminder: Reminder
    let duck: Duck
    
    let editAction: () -> Void
    let removeAction: () -> Void
    
    var body: some View {
        SwipeView {
            VStack(spacing: 0) {
                HStack(spacing: 6) {
                    if reminder.frequency == .specificDates {
                        Text(duck.specificReminderDate.formatted(.dateTime.year().month(.twoDigits).day()))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.brust(with: 16))
                            .foregroundStyle(.baseDarkGray)
                        
                        Spacer()
                    } else {
                        Text(reminder.frequency?.title ?? "")
                            .frame(height: 36)
                            .padding(.horizontal, 15)
                            .font(.brust(with: 16))
                            .foregroundStyle(.baseYellow)
                            .overlay {
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(.baseYellow, lineWidth: 3)
                            }
                    }
                    
                    Text(reminder.type?.title ?? "")
                        .frame(height: 36)
                        .padding(.horizontal, 15)
                        .font(.brust(with: 16))
                        .foregroundStyle(.baseYellow)
                        .overlay {
                            RoundedRectangle(cornerRadius: 13)
                                .stroke(.baseYellow, lineWidth: 3)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(reminder.comment)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.brust(with: 20))
                    .foregroundStyle(.black)
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

#Preview {
    ZStack {
        Color.baseDarkGray
        DuckReminderCellView(reminder: Reminder(isReal: false), duck: Duck(isReal: false)) {} removeAction: {}
            .padding()
    }
}
