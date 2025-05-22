import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuizMaker()
                .tabItem {
                    Label("Make a Quiz", systemImage: "pencil.line")
                }
            QuizList()
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet")
                }
        }
    }
}

#Preview {
    ContentView()
}
