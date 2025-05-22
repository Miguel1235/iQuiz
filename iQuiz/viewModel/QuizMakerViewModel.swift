import Foundation

final class QuizMakerViewModel: ObservableObject {
    var difficulties: [String] = ["easy", "medium", "hard"]
    @Published var selectedDificulty: String
    
    var types: [String] = ["multiple", "boolean", "both"]
    @Published var selectedType: String
    
    var numberOfQuestions: [Int] = [5,10,15,20,25,30]
    @Published var selectedNumberOfQuestions: Int
    
    var categories: [QuizCategory] = [QuizCategory(id: 9, name: "General Knowledge")]
    @Published var selectedCategory: QuizCategory
    
    @Published var isLoading = false
    @Published var textError = ""
    
    
    init() {
        selectedDificulty = difficulties.randomElement()!
        selectedType = types.randomElement()!
        selectedNumberOfQuestions = numberOfQuestions.randomElement()!
        selectedCategory = categories.first!
    }
    
    func getCategories() async {
                isLoading = true
                let result = await Api.shared.getCategories()
                isLoading = false
                switch result {
                case .success(let cats):
                    categories = cats
                case .failure(let error):
                    selectedCategory = QuizCategory(id: 9, name: "General Knowledge")
                    textError = error.localizedDescription
                }
    }
    
    func getApiUrl() -> String {
        var components = URLComponents(string: "\(Api.shared.baseUrl)/api.php")
        components?.queryItems = [
            URLQueryItem(name: "amount", value: String(selectedNumberOfQuestions)),
            URLQueryItem(name: "category", value: String(selectedCategory.id)),
            URLQueryItem(name: "difficulty", value: selectedDificulty),
        ]
        
        if selectedType != "both" {
            components?.queryItems?.append(URLQueryItem(name: "type", value: selectedType))
        }
        return components!.url!.absoluteString
    }
}
