import SwiftUI

struct BaseCustomTextField: View {
    
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
        HStack {
            TextField("", text: $text, prompt: Text(placeholder)
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.baseGray)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.system(size: 20, weight: .medium))
            .foregroundStyle(.black)
            .keyboardType(keyboardType)
            .focused($isFocused)
            
            if text != "" {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundStyle(.white.opacity(0.5))
                }
            }
        }
        .frame(height: 60)
        .padding(.horizontal, 12)
        .background(.white)
        .cornerRadius(18)
        .animation(.default, value: text)
    }
}

