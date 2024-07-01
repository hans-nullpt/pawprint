//
//  WordResult.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import Foundation

enum WordErrorType {
    case letterError
    case wordError
}

struct WordAnalyzeResult {
    var value: String
    var isError: Bool = false
    var error: WordErrorType?
}

struct WordResult {
    var value: String
    var hasError: Bool = false
    var results: [WordAnalyzeResult] = []
}

