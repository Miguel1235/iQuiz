//
//  ResponseQuiz.swift
//  iQuiz
//
//  Created by Miguel Del Corso on 21/05/2025.
//

struct ResponseQuiz: Codable {
    let responseCode: Int
    let results: [Quiz]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}
