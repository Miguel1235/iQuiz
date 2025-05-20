//
//  utils.swift
//  iQuiz
//
//  Created by Miguel Del Corso on 18/05/2025.
//
import Foundation

func load<T: Decodable> (_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename) in main bundle")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle: \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't decode \(filename) from data: \(error)")
    }
}

func html2string(_ html: String) -> String {
    if let attributedString = try? NSAttributedString(
        data: Data(html.utf8),
        options: [.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil
    ) {
        return attributedString.string
    } else {
        return "Failed to decode HTML entities"
    }
}
