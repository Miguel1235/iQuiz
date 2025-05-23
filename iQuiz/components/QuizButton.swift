import SwiftUI

struct QuizButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
                
        Button {
            action()
        } label: {
            Label(text, systemImage: "")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .clipShape(Capsule())
        .padding([.horizontal])
        .tint(Color.indigo.opacity(0.8).mix(with: .red, by: 0.5).gradient)
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}

#Preview {
    QuizButton(text: "Click!", action: {
        
    })
}
