import SwiftUI

struct StrokeText: View {
    
    let text: String
    let lineWidth: CGFloat
    let fontSize: CGFloat
    let mainColor: Color?
    let backColor: Color?
    
    init(
        _ text: String,
        lineWidth: CGFloat = 2,
        fontSize: CGFloat,
        mainColor: Color? = nil,
        backColor: Color? = nil
    ) {
        self.text = text
        self.lineWidth = lineWidth
        self.fontSize = fontSize
        self.mainColor = mainColor
        self.backColor = backColor
    }
    
    var body: some View {
        ZStack {
            Group {
                Text(text).offset(x: -2, y: -2)
                Text(text).offset(x: 0, y: -2)
                Text(text).offset(x: 2, y: -2)
                Text(text).offset(x: -2, y: 0)
                Text(text).offset(x: 2, y: 0)
                Text(text).offset(x: -2, y: 2)
                Text(text).offset(x: 0, y: 2)
                Text(text).offset(x: 2, y: 2)
            }
            .font(.brust(with: fontSize))
            .foregroundStyle(backColor == nil ? .black : backColor ?? .black)
            
            Text(text)
                .font(.brust(with: fontSize))
                .foregroundStyle(mainColor == nil ? .baseYellow : mainColor ?? .baseYellow)
        }
    }
}
