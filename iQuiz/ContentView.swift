import SwiftUI

struct ContentView: View {
    @State private var current = 0
    @State private var isGameOver = false
    let quizData: [Quiz] = load("quiz.json")
    
    var question: String {
        html2string(quizData[current].question)
    }
    var answers: [String] {
        let current = quizData[current]
        return (current.incorrectAnswers + [current.correctAnswer]).shuffled()
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 64) {
            QuestionText(question: question)
            VStack(alignment: .leading) {
                ForEach(answers, id: \.self) { answer in
                    QuizButton(text: answer) {
                        isGameOver = current + 1 == quizData.count
                        print("\(current) \(quizData.count) \(isGameOver)")

                        if !isGameOver {
                            current = current + 1
                        }
                        print("\(current) \(quizData.count)")
                    }
                }
            }
            HStack(alignment: .bottom) {
                Spacer()
                Text("\(current+1)/\(quizData.count)")
            }
        }
        .alert("Game over", isPresented: $isGameOver) {
            Button("Reset") {
                current = 0
            }
        }
        .padding()
    }
}

struct QuestionText: View {
    var question: String
    var body: some View {
        Text(question)
            .font(.title)
            .bold()
            .lineLimit(3)
            .minimumScaleFactor(0.5)
            .multilineTextAlignment(.center)
    }
}

struct QuizButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
        Button(text) {
            action()
        }
        .buttonStyle(.bordered)
        .controlSize(.mini)
        .tint(Color.indigo.opacity(0.8).mix(with: .red, by: 0.5).gradient)
    }
}

#Preview {
    ContentView()
}
