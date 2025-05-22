import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            QuizList()
                .tabItem {
                    Label("Quizzes", systemImage: "list.bullet")
                }
            
            QuizMaker()
                .tabItem {
                    Label("Make a Quiz", systemImage: "pencil.line")
                }
        }
    }
}

#Preview {
    ContentView()
}
