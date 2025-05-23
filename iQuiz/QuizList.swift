import SwiftUI

struct QuizList: View {
    struct QuizDemos: Hashable {
        let text: String
        let url: String
        let image: String
    }
    
    var quizzesList: [QuizDemos] = [
        QuizDemos(text: "General", url: "", image: "brain"),
        QuizDemos(text: "Sports", url: "https://opentdb.com/api.php?amount=10&category=21", image: "soccerball"),
        QuizDemos(text: "Science", url: "https://opentdb.com/api.php?amount=10&category=17", image: "flask"),
    ]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(quizzesList, id: \.self) { quiz in
                    NavigationLink(destination: QuizGame(url: quiz.url)) {
                        Label(quiz.text, systemImage: quiz.image)
                    }
                }
            }
            .navigationTitle("Quizzes")
        }
    }
}

#Preview {
    QuizList()
}
