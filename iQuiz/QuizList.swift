import SwiftUI

struct QuizList: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: QuizGame()) {
                    Text("General quiz")
                }
            }
            .navigationTitle("Quizzes")
        }
    }
}

#Preview {
    QuizList()
}
