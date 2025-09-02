import SwiftUI

struct AddEventListView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var ducs: [Duck]
    
    @State private var selectedDuck: Duck?
    @State private var isShowAddEventView = false
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 25) {
                navigationView
                duckList
                completeButton
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 35)
            
            NavigationLink(isActive: $isShowAddEventView) {
                AddEventView(duck: selectedDuck ?? Duck(isReal: true))
            } label: {
                EmptyView()
            }
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
    
    private var duckList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 12) {
                ForEach(ducs) { duck in
                    AddEventListCellView(duck: duck, selectedDuck: $selectedDuck)
                }
            }
        }
    }
    
    private var completeButton: some View {
        Button {
            isShowAddEventView = true
        } label: {
            Image(selectedDuck == nil ? .Images.Buttons.completeInactive : .Images.Buttons.complete)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
        }
        .disabled(selectedDuck == nil)
    }
}
