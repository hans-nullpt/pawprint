//
//  SoundViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 07/07/24.
//

import Foundation
import AVFAudio

class SoundViewModel: ObservableObject {
    static let musicInstance = SoundViewModel()
    
    var player: AVAudioPlayer?
    @Published var soundEffectStatus: Bool = false
    
    enum SoundOption: String {
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
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else {
            print("Error: Sound file not found.")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("Playing sound: \(sound.rawValue)")
            player?.volume = 1
            player?.numberOfLoops = 10
            
        } catch let error {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    func stopSound() {
        player?.stop() 
    }
}
