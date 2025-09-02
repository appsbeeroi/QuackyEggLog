import SwiftUI

struct AddEventView: View {
    
    @EnvironmentObject var viewModel: StatisticsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State var duck: Duck
    
    @State private var event = Event(isReal: true)
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 25) {
                navigationView
                eventTypeList
                datePickerSection
                
                Spacer()
                
                completeButton
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
            .padding(.bottom, 96)
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
            
            Text("ADD EVENT")
                .font(.brust(with: 35))
                .foregroundStyle(.black)
                .offset(y: 10)
        }
    }
    
    private var eventTypeList: some View {
        HStack(spacing: 10) {
            ForEach(EventType.allCases) { type in
                EventTypeCell(type: type, selectedEventType: $event.eventType)
                    .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    private var datePickerSection: some View {
        DatePicker("", selection: $event.eventDate, in: ...Date())
            .labelsHidden()
            .datePickerStyle(.wheel)
            .padding(10)
            .background(.white)
            .cornerRadius(18)
    }
    
    private var completeButton: some View {
        Button {
            duck.events.append(event)
            viewModel.save(duck)
        } label: {
            Image(event.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
        }
        .disabled(!event.isUnlock)
    }
}

#Preview {
    AddEventView(duck: Duck(isReal: false))
}
