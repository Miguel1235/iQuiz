import SwiftUI

struct ContentView: View {
    @StateObject private var vm = QuizViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            MainText(question: vm.getCurrentQuestion())
            ForEach(vm.getAnsers(), id: \.self) { answer in
                QuizButton(text: answer) {
                    if !vm.checkGameOver() {
                        vm.go2NextQuestion()
                    }
                }
            }
            HStack(alignment: .bottom) {
                Spacer()
                Text("\(vm.current+1)/\(vm.quizData.count)")
                    .padding()
            }
        }
        .alert("Game over", isPresented: $vm.isGameOver) {
            Button("Reset") {
                vm.resetGame()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
