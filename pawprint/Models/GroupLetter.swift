//
//  GroupLetter.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation

struct PracticeSentence: Hashable {
    var step: String
    var value: String
}

enum LowerCaseLetterType: CaseIterable {
    case acdgoq
    case ijltu
    case bhkl
    case mnrvw
    case vwxz
    case efs
    
    var description: [String] {
        switch (self) {
            
        case .acdgoq:
            return ["a", "c", "d", "g", "o", "q"]
        case .ijltu:
            return ["i", "j", "l", "t", "u"]
        case .bhkl:
            return ["b", "h", "k", "l"]
        case .mnrvw:
            return ["m", "n", "r", "v", "w"]
        case .vwxz:
            return ["v", "w", "x", "z"]
        case .efs:
            return ["e", "f", "s"]
        }
    }
    
    var sentences: [[PracticeSentence]] {
        switch (self) {
            
        case .acdgoq:
            return [
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "cats and"),
                    PracticeSentence(step: "Practice 2", value: "cats and dogs often"),
                    PracticeSentence(step: "Practice 3", value: "cats and dogs often quarrel"),
                    PracticeSentence(step: "Practice 4", value: "cats and dogs often quarrel over food")
                ],
                [
                    /// Sentence 2
                ],
                /// dst
            ]
        case .ijltu:
            return [
                [
                    PracticeSentence(step: "Practice 1", value: ""),
                    PracticeSentence(step: "Practice 2", value: ""),
                    PracticeSentence(step: "Practice 3", value: ""),
                    PracticeSentence(step: "Practice 4", value: "")
                ]
            ]
        case .bhkl:
            return []
        case .mnrvw:
            return []
        case .vwxz:
            return []
        case .efs:
            return []
        }
    }
}

enum UpperCaseLetterType: CaseIterable {
    case cgoq
    case ijltu
    case bdfhk
    case bprs
    case axyz
    case mnvw
    
    var description: [String] {
        switch (self) {
        
        case .cgoq:
            return ["C", "G", "O", "Q"]
        case .ijltu:
            return ["I", "J", "L", "T", "U"]
        case .bdfhk:
            return ["B", "D", "F", "H", "K"]
        case .bprs:
            return ["B", "P", "R", "S"]
        case .axyz:
            return ["A", "X", "Y", "Z"]
        case .mnvw:
            return ["M", "N", "V", "W"]
        }
    }
    
    var sentences: [[PracticeSentence]] {
        switch (self) {
            
        case .cgoq:
            return []
        case .ijltu:
            return []
        case .bdfhk:
            return []
        case .bprs:
            return []
        case .axyz:
            return []
        case .mnvw:
            return []
        }
    }
}

enum LetterType {
    case lowerCase
    case upperCase
}

struct GroupLetterItem: Identifiable {
    var id: UUID = UUID()
    var type: LetterType
    var letters: [String]
    var sentences: [[PracticeSentence]]
    
    static var lowerCaseItems: [GroupLetterItem] {
        return LowerCaseLetterType.allCases.map { type in
            GroupLetterItem(
                type: .lowerCase, letters: type.description, sentences: type.sentences
            )
        }
    }
    
    static var upperCaseItems: [GroupLetterItem] {
        return UpperCaseLetterType.allCases.map { type in
            GroupLetterItem(
                type: .upperCase, letters: type.description, sentences: type.sentences
            )
        }
    }
}
