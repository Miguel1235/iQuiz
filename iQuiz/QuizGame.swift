import SwiftUI

struct QuizGame: View {
    @StateObject private var vm = QuizViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var url: String = ""
    
    var body: some View {
        VStack(alignment: .center) {
            if vm.isLoading {
                ProgressView("Obtaining questions...")
                    .controlSize(.large)
            } else if !vm.textError.isEmpty {
                Text("Ups there was an error: \(vm.textError)")
            } else if vm.quizData.isEmpty {
                ContentUnavailableView() {
                    Label("No questions", systemImage: "tray")
                }
            } else  {
                HStack(alignment: .bottom) {
                    Spacer()
                    Text("\(vm.current+1)/\(vm.quizData.count)")
                        .padding()
                }
                Spacer()
                MainText(question: vm.getCurrentQuestion())
                Spacer()
                ForEach(vm.getAnsers(), id: \.self) { answer in
                    QuizButton(text: answer) {
                        if !vm.checkGameOver() {
                            vm.go2NextQuestion()
                        }
                    }
                }
            }
        }
        .onAppear {
            Task {
                await vm.getQuestions(url: url)
            }
        }
        .alert("Game over", isPresented: $vm.isGameOver) {
            Button("Oki") {
                vm.resetGame()
                dismiss()
            }
        }
        .padding()
    }
}

#Preview {
    QuizGame()
}
