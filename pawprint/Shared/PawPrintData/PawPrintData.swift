//
//  PawPrintData.swift
//  pawprint
//
//  Created by Isaac Tambunan on 07/07/24.
//

import Foundation
import SwiftData

@Model
class PawPrintData {
    var name: String = "pawprint-app"
    var practiceData: PracticeResult?

    init(name: String) {
        self.name = "pawprint-app"
    }
}
