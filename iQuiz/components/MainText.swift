import SwiftUI

struct MainText: View {
    var question: String
    var body: some View {
        Text(question)
            .font(.title)
            .bold()
            .lineLimit(3)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
            .padding()
    }
}
