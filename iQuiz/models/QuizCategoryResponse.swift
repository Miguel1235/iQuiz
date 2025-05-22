import Foundation

struct QuizCategoryResponse: Codable {
    let triviaCategories: [QuizCategory]

    enum CodingKeys: String, CodingKey {
        case triviaCategories = "trivia_categories"
    }
}
