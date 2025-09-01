import SwiftUI

struct AddFeedingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var feedings: DuckFeeding
    
    let save: (DuckFeeding) -> Void
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 35) {
                navigationView
                
                VStack(spacing: 8) {
                    DatePicker("", selection: $feedings.date)
                        .labelsHidden()
                        .datePickerStyle(.wheel)
                        .padding(5)
                        .background(.white)
                        .cornerRadius(18)
                    
                    VStack(spacing: 8) {
                        BaseCustomTextField(text: $feedings.type, placeholder: "Type of feed", isFocused: $isFocused)
                        
                        BaseCustomTextField(
                            text: $feedings.quantity,
                            placeholder: "Quontity",
                            keyboardType: .numberPad,
                            isFocused: $isFocused
                        )
                    }
                    .padding(.horizontal, 35)
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            HStack {
                                Button("Done") {
                                    isFocused = false
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }
                
                Spacer()
                
                Button {
                    save(feedings)
                    dismiss()
                } label: {
                    Image(feedings.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
                .disabled(!feedings.isUnlock)
            }
            .frame(maxHeight: .infinity, alignment: .top)
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
            .padding(.horizontal, 35)
            
            Text("ADD FEEDINGS")
                .font(.brust(with: 35))
                .foregroundStyle(.black)
                .offset(y: 10)
        }
    }
}

#Preview {
    NavigationView {
        AddFeedingsView(feedings: DuckFeeding(isReal: false)) { _ in }
    }
}
