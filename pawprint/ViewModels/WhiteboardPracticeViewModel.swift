//
//  WhiteboardPracticeViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import Combine
import AVFoundation

enum PracticeState {
    case started
    case initial
    case stopped
    case timesup
}

class WhiteboardPracticeViewModel: ObservableObject {
    @Published var sentence: String = ""
    @Published var intervalTime: TimeInterval = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var practiceState: PracticeState = .initial
    @Published var isPracticeStarted: Bool = false
    var data: GroupLetterItem?
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    
    private let voice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice()
    private var speechRate: Float = AVSpeechUtteranceDefaultSpeechRate
    private let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    
    @Published var showTimesUpPopup: Bool = false
    
    init() {
        startTimer()
    }
    
    func getSentence() {
        
        if let sentence = data?.sentences.randomElement()?.last {
            self.sentence = sentence.value
            self.remainingTime = getTimeInterval()
            self.intervalTime = getTimeInterval()
            self.speechRate = -Float(getTimeInterval())
            self.practiceState = .started
            self.isPracticeStarted = true
            startPractice()
        }
    }
    
    func startPractice() {
        startTimer()
        
        for word in sentence.split(separator: " ") {
            speak(word: String(word))
        }
    }
    
    private func startTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        remainingTime = intervalTime
    }
    
    var hasCountdownCompleted: Bool {
        remainingTime < 1
    }
    
    private func getTimeInterval() -> TimeInterval {
        guard !self.sentence.isEmpty else {
            return 0
        }
        
        let letterCount = self.sentence.count
        
        return Double(letterCount)
    }
    
    func updateTimer() {
        guard hasCountdownCompleted else {
            self.remainingTime -= 1
            return
        }
        
        /// TODO: Play times up sound effect
        self.timer?.upstream.connect().cancel()
        
        /// Stop the voice over
        if speechSynthesizer.isSpeaking {
            stopVoiceOver()
        }
        
        self.showTimesUpPopup.toggle()
    }
    
    func speak(word: String) {
        let utterance: AVSpeechUtterance = AVSpeechUtterance(string: word)
        utterance.preUtteranceDelay = 2
        utterance.postUtteranceDelay = 2
        utterance.voice = self.voice
        utterance.rate = self.speechRate
        
        speechSynthesizer.speak(utterance)
    }
    
    func stopVoiceOver() {
        speechSynthesizer.stopSpeaking(at: .immediate)
    }
    
}
