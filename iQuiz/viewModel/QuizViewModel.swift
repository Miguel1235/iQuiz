import Foundation
//import Observation

final class QuizViewModel: ObservableObject {
    @Published var current = 0
    @Published var isGameOver = false
    @Published var quizData: [Quiz] = []
    @Published var isLoading = false
    @Published var textError = ""
    @Published var correctAnswers = 0
    
    
    private var timer: Timer?
    @Published var isTimerRunning = false
    @Published var timeElapsed = 0
    
    private var shuffledAnswers: [[String]] = []
    
    
    
    
    func startTimer() {
        if(current != 0) { return }
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timeElapsed += 1
        }
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        stopTimer()
        timeElapsed = 0
    }
    
    func isQuizPassed() -> Bool {
        if quizData.isEmpty { return false }
        return ((correctAnswers * 100 ) / quizData.count) > 65
    }
    
    private func generateShuffledAnswers() {
        shuffledAnswers = quizData.map { quiz in
            (quiz.incorrectAnswers + [quiz.correctAnswer]).shuffled()
        }
    }
    
    func getAnsers() -> [String] {
        //        let current = quizData[current]
        //        return (current.incorrectAnswers + [current.correctAnswer]).shuffled()
        
        // Return cached shuffled answers
        if current < shuffledAnswers.count {
            return shuffledAnswers[current]
        }
        return []
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
        if isGameOver { stopTimer() }
        return isGameOver
    }
    
    func resetGame() {
        current = 0
        isGameOver = false
        resetTimer()
        if !quizData.isEmpty {
            generateShuffledAnswers()
        }
    }
    
    func getQuestions(url: String = "") async {
        //        quizData = load("quiz.json")
        isLoading = true
        let result = await Api.shared.getApiQuestions(url: url)
        isLoading = false
        switch result {
        case .success(let questions):
            quizData = questions
            generateShuffledAnswers()
        case .failure(let error):
            quizData = []
            textError = error.localizedDescription
        }
    }
}
