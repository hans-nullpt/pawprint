//
//  pawprintApp.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 25/06/24.
//

import SwiftUI
import SwiftData

@main
struct pawprintApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(HandwritingAnalyzeResultViewModel())
                .environmentObject(WhiteboardPracticeViewModel())
                .environmentObject(SoundViewModel.musicInstance)
                .modelContainer(for: [
                    HandwritingHistory.self
                ])
        }
    }
}
