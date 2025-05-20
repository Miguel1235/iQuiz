//
//  Quiz.swift
//  iQuiz
//
//  Created by Miguel Del Corso on 18/05/2025.
//

import Foundation

struct Quiz: Codable {
    let type: TypeEnum
    let difficulty: Difficulty
    let category, question, correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type, difficulty, category, question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }
}

enum Difficulty: String, Codable {
    case EASY = "easy"
    case HARD = "hard"
    case MEDIUM = "medium"
}

enum TypeEnum: String, Codable {
    case BOOLEAN = "boolean"
    case MULTIPLE = "multiple"
}
