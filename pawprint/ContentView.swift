//
//  ContentView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 25/06/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("soundOn") var soundOn: Bool = true
    var body: some View {
        ZStack {
            if soundOn {
                Image("buttonaudio")
                    .offset(x: 341, y: -300)
                    .onTapGesture {
                        soundOn.toggle()
                        muteOrPlay()
                    }
            }else {
                Image("buttonmute")
                    .offset(x: 341, y: -300)
                    .onTapGesture {
                        soundOn.toggle()
                        muteOrPlay()
                    }
            }
            
        }
        .padding()
    }
    func muteOrPlay(){
        if !soundOn {
            SoundManager.musicInstance.player?.stop()
        }else {
            SoundManager.musicInstance.musicStatus = true
            SoundManager.musicInstance.playSound(sound: .pawprintsound)
            SoundManager.musicInstance.player?.volume = 1.0
            SoundManager.musicInstance.player?.numberOfLoops = 10
        }
    }
}

#Preview {
    ContentView()
}
