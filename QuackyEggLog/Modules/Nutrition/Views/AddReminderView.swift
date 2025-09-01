import SwiftUI

struct AddReminderView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var reminder: Reminder
    
    let save: (Reminder) -> Void
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 25) {
                navigationView
                typeSection
                reminderSection
                
                AdaptableCustomTextField(text: $reminder.comment, placeholder: "Comment", isFocused: $isFocused)
                    .frame(height: 110)
                
                Spacer()
                
                Button {
                    save(reminder)
                    dismiss()
                } label: {
                    Image(reminder.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
                .disabled(!reminder.isUnlock)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigationView: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(.Images.Buttons.back)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65, height: 65)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 25)
            
            Text("ADD FEEDINGS")
                .font(.brust(with: 35))
                .foregroundStyle(.black)
                .offset(y: 10)
        }
    }
    
    private var typeSection: some View {
        VStack(spacing: 10) {
            Text("REMINDER TYPE")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 18))
                .foregroundStyle(.black)
            
            HStack(spacing: 8) {
                ForEach(ReminderType.allCases) { type in
                    ReminderTypeView(type: type, selectedType: $reminder.type)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var reminderSection: some View {
        VStack(spacing: 10) {
            Text("FREQUENCY")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.brust(with: 18))
                .foregroundStyle(.black)
            
            VStack(spacing: 10) {
                HStack(spacing: 8) {
                    FrequencyTypeView(type: .daily, selectedType: $reminder.frequency)
                    FrequencyTypeView(type: .every3days, selectedType: $reminder.frequency)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                HStack(spacing: 8) {
                    FrequencyTypeView(type: .everyWeek, selectedType: $reminder.frequency)
                    FrequencyTypeView(type: .specificDates, selectedType: $reminder.frequency)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    NavigationView {
        AddReminderView(reminder: Reminder(isReal: false)) { _ in }
    }
}



