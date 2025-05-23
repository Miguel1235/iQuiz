import Foundation
//import Observation

final class QuizViewModel: ObservableObject {
    @Published var current = 0
    @Published var isGameOver = false
    @Published var quizData: [Quiz] = []
    @Published var isLoading = false
    @Published var textError = ""
    @Published var correctAnswers = 0
    
    func isQuizPassed() -> Bool {
        if quizData.isEmpty { return false }
        return ((correctAnswers * 100 ) / quizData.count) > 65
    }
    
    
    func getAnsers() -> [String] {
        let current = quizData[current]
        return (current.incorrectAnswers + [current.correctAnswer]).shuffled()
    }
    
    func getCurrentQuestion() -> String {
        return html2string(quizData[current].question)
    }
    
    func checkAnswer(_ answer: String) {
        if(answer == quizData[current].correctAnswer) {
            correctAnswers += 1
        }
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
    
    func getQuestions(url: String = "") async {
//        quizData = load("quiz.json")
        isLoading = true
        let result = await Api.shared.getApiQuestions(url: url)
        isLoading = false
        switch result {
        case .success(let questions):
            quizData = questions
        case .failure(let error):
            quizData = []
            textError = error.localizedDescription
        }
    }
}
