import SwiftUI

struct AdaptableCustomTextField: View {
    
    @Binding var text: String
    
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    @FocusState.Binding var isFocused: Bool
    
    init(
        text: Binding<String>,
        placeholder: String,
        keyboardType: UIKeyboardType = .default,
        isFocused: FocusState<Bool>.Binding
    ) {
        self._text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self._isFocused = isFocused
    }
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Text(text == "" ? placeholder : text)
                        .frame(maxHeight: .infinity, alignment: .topLeading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 12)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(text == "" ? .baseGray : .black)
                
                    TextEditor(text: $text)
                        .frame(maxHeight: .infinity)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.black)
                        .opacity(0.05)
                }
                
                if text != "" {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white.opacity(0.1))
                    }
                }
            }
        }
        .frame(minHeight: 100)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(18)
        .animation(.default, value: text)
    }
}
