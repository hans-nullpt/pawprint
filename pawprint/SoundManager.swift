//
//  SoundManager.swift
//  pawprint
//
//  Created by Karina Gusti on 05/07/24.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    static let musicInstance = SoundManager()
    
    var player: AVAudioPlayer?
    @Published var musicStatus: Bool = false
    @Published var soundEffectStatus: Bool = false
    
    enum soundOption: String {
        case pawprintsound
    }
    
    init() {
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print("Error setting up AVAudioSession: \(error.localizedDescription)")
        }
    }
    
    func playSound(sound: soundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else {
            print("Error: Sound file not found.")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("Playing sound: \(sound.rawValue)")

        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

struct SoundView: View {
    @AppStorage("soundOn") var soundOn: Bool = true
    var body: some View {
        VStack {
            // Your view content here
        }
        .onAppear {
            if soundOn {
                SoundManager.musicInstance.musicStatus = true
                SoundManager.musicInstance.playSound(sound: .pawprintsound)
                SoundManager.musicInstance.player?.volume = 1.0
                SoundManager.musicInstance.player?.numberOfLoops = 10
            }
            }
        }
    }


#Preview {
    SoundView()
}
