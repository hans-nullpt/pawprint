//
//  WordResult.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import Foundation

enum WordErrorType: Codable {
    case letterError
    case wordError
}

struct WordAnalyzeResult: Codable {
    var value: String
    var actualLetter: String
    var isError: Bool = false
    var error: WordErrorType?
}

struct LetterCount: Codable {
    var value: String
    var total: Int
    var error: Int
}

struct WordResult: Codable {
    var value: String
    var hasError: Bool = false
    var results: [WordAnalyzeResult] = []
}

