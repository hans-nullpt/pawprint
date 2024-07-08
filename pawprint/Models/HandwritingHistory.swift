//
//  HandwritingHistory.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 07/07/24.
//

import Foundation
import SwiftData
import UIKit

@Model
class HandwritingHistory {
    var sentence: String
    var letters: String
    var type: String
    var readibilityPercentage: Double
    var timestamp: Date
    var mode: String
    
    init(sentence: String, letters: String, type: String, readibilityPercentage: Double, timestamp: Date, mode: PracticeModeType) {
        self.sentence = sentence
        self.letters = letters
        self.type = type
        self.readibilityPercentage = readibilityPercentage
        self.timestamp = timestamp
        self.mode = mode.rawValue
    }
}
