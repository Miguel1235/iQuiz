import SwiftUI

struct QuizMaker: View {
    @StateObject private var vm = QuizMakerViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Number of questions") {
                    PickerString(items: vm.numberOfQuestions, text2Show: "Number of questions", selectedItem: $vm.selectedNumberOfQuestions, displayText: { "\($0)" })
                        .pickerStyle(.segmented)
                }
                Section("Select difficulty") {
                    PickerString(items: vm.difficulties, text2Show: "Select difficulty", selectedItem: $vm.selectedDificulty, displayText: { "\($0)"} )
                        .pickerStyle(.segmented)
                }
                
                Section("Select type") {
                    PickerString(items: vm.types, text2Show: "Select type", selectedItem: $vm.selectedType, displayText: { "\($0)" })
                }
                Section("Select category") {
                    
                    if vm.isLoading {
                        ProgressView()
                    } else if !vm.textError.isEmpty {
                        Text("Ups there was an error: \(vm.textError)")
                    } else if vm.categories.isEmpty {
                        ContentUnavailableView() {
                            Label("No questions", systemImage: "tray")
                        }
                    } else  {
                        PickerString(items: vm.categories, text2Show: "Select type", selectedItem: $vm.selectedCategory, displayText: { "\($0.name)" })
                            .pickerStyle(.navigationLink)
                    }
                }
                
                    NavigationLink(destination: QuizGame(url: vm.getApiUrl())) {
                        Text("Start quiz")
                            .bold()
                    }
            }
            .navigationTitle(Text("Quiz Maker"))
        }
        .onAppear {
            Task {
                await vm.getCategories()
            }
        }
    }
}

struct PickerString<T: Hashable>: View {
    var items: [T]
    var text2Show: String
    @Binding var selectedItem: T
    var displayText: (T) -> String
    
    
    
    var body: some View {
        Picker(text2Show, selection: $selectedItem) {
            ForEach(items, id: \.self) {
                Text(displayText($0))
            }
        }
    }
}

#Preview {
    QuizMaker()
}
