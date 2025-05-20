import Foundation
//import Observation

final class QuizViewModel: ObservableObject {
    @Published var current = 0
    @Published var isGameOver = false
    @Published var quizData: [Quiz] = load("quiz.json")
    
    
    func getAnsers() -> [String] {
        let current = quizData[current]
        return (current.incorrectAnswers + [current.correctAnswer]).shuffled()
    }
    
    func getCurrentQuestion() -> String {
        return html2string(quizData[current].question)
    }
    
    func go2NextQuestion() {
        current += 1
    }
    
    func checkGameOver() -> Bool {
        isGameOver = current + 1 == quizData.count
        return isGameOver
    }
    
    func resetGame() {
        current = 0
        isGameOver = false
    }
}
