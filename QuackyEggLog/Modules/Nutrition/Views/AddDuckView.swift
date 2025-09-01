import SwiftUI

struct AddDuckView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: NutritionViewModel
    
    @State var duck: Duck
    
    @State private var state: AddDuckViewState = .form
    
    @State private var isShowImagePicker = false
    @State private var isShowDuckDetail = false
    @State private var hasDuckEdited = false
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.background)
                .scaleToFillAndCropp()
            
            VStack(spacing: 35) {
                switch state {
                    case .form:
                        navigationView
                        formView
                    case .added:
                        addedDuckView
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.smooth, value: state)
            
            NavigationLink(isActive: $isShowDuckDetail) {
                DuckDetailView(duck: duck)
                    .onDisappear {
                        state = .form
                    }
            } label: {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isShowImagePicker) {
            ImagePickerView(selectedImage: $duck.image)
        }
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
            
            Text("Add a duck")
                .font(.brust(with: 35))
                .foregroundStyle(.black)
                .offset(y: 10)
        }
    }
    
    private var formView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                Button {
                    isShowImagePicker = true
                } label: {
                    Group {
                        if let image = duck.image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                        } else {
                            Rectangle()
                                .foregroundStyle(.white)
                                .overlay {
                                    Image(systemName: "photo.fill")
                                        .font(.system(size: 60, weight: .bold))
                                        .foregroundStyle(.baseGray.opacity(0.5))
                                }
                        }
                    }
                    .frame(width: 112, height: 112)
                    .cornerRadius(25)
                }
                
                BaseCustomTextField(text: $duck.name, placeholder: "Name", isFocused: $isFocused)
                BaseCustomTextField(text: $duck.breed, placeholder: "Breed", isFocused: $isFocused)
                
                BaseCustomTextField(
                    text: $duck.age,
                    placeholder: "Age",
                    keyboardType: .numberPad,
                    isFocused: $isFocused
                )
                
                BaseCustomTextField(
                    text: $duck.weight,
                    placeholder: "Weight",
                    keyboardType: .numberPad,
                    isFocused: $isFocused
                )
                
                AdaptableCustomTextField(text: $duck.features, placeholder: "Features", isFocused: $isFocused)
                
                Button {
                    if hasDuckEdited {
                        isShowDuckDetail = true
                    } else {
                        state = .added
                        hasDuckEdited = true
                    }
                } label: {
                    Image(duck.isUnlock ? .Images.Buttons.complete : .Images.Buttons.completeInactive)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                }
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
            .onAppear {
                hasDuckEdited = !duck.feedings.isEmpty
            }
        }
    }
    
    private var addedDuckView: some View {
        VStack(spacing: 14) {
            HStack {
                Text("✅")
                    .font(.system(size: 40, weight: .medium))
                
                StrokeText("Duck is added!", fontSize: 40)
            }
            
            Text("Add the first feeding for\nthis duck?")
                .font(.brust(with: 25))
                .foregroundStyle(.black)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 6) {
                Button {
                    isShowDuckDetail = true
                } label: {
                    Image(.Images.baseWood)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 45)
                        .overlay {
                            Text("yes")
                                .font(.brust(with: 25))
                                .foregroundStyle(.white)
                        }
                }
                
                Button {
                    viewModel.save(duck)
                } label: {
                    Image(.Images.baseWood)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 45)
                        .overlay {
                            Text("later")
                                .font(.brust(with: 25))
                                .foregroundStyle(.white)
                        }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    AddDuckView(duck: Duck(isReal: false))
}
