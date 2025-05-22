import Foundation
//import Observation

final class QuizViewModel: ObservableObject {
    @Published var current = 0
    @Published var isGameOver = false
    @Published var quizData: [Quiz] = []
    @Published var isLoading = false
    @Published var textError = ""
    
    
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
    
    func getQuestions() async {
        quizData = load("quiz.json")
//        isLoading = true
//        let result = await Api.shared.getApiQuestions()
//        isLoading = false
//        switch result {
//        case .success(let questions):
//            quizData = questions
//        case .failure(let error):
//            quizData = []
//            textError = error.localizedDescription
//        }
    }
}
