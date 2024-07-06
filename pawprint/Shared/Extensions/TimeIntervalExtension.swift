//
//  TimeIntervalExtension.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import Foundation

extension TimeInterval {
    var countdownTimer : String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
