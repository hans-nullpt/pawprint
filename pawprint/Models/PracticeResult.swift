//
//  PracticeResult.swift
//  pawprint
//
//  Created by Isaac Tambunan on 06/07/24.
//

import Foundation
import UIKit
import SwiftData

@Model
class PracticeResult: Identifiable {
    var groupLetter: String? = ""
    var imageResult: String? = ""
    var textResult: String? = ""

    init(groupLetter: String, imageResult: String, textResult: String) {
        self.groupLetter = groupLetter
        self.imageResult = imageResult
        self.textResult = textResult
    }
}

//struct PracticeResult: Codable {
//    var groupLetter: String? = ""
//    var imageResult: String? = ""
//    var textResult: String? = ""
//}
