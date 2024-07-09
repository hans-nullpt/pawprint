//
//  PracticeViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import UIKit
import CoreMotion
import Vision
import SwiftUI
import Combine

class IpadPracticeViewModel: ObservableObject {
    //    @Published var groupLetter: String = ""
    //    @Published var imageResult: UIImage?
    //    @Published var textResult: String = ""
    @Published var gravityValue: String = ""
    @Published var isSurfacePositionNotValid: Bool = true
    @Published var capturedImage: UIImage?
    @Published var imageRect: CGRect = CGRectZero
    @Published var contentIndex: Int = 0
    @Published var sentence: String = ""
    @Published var sentences: [PracticeSentence] = []
    @Published var isBlankScreen: Bool = false
    @Published var isNextScreen: Bool = false
    @Published var data: GroupLetterItem?
    @Published var scannedText: String = ""    
    @Published var intervalTime: TimeInterval = 0
    @Published var remainingTime: TimeInterval = 0
    @Published var isPracticeStarted: Bool = false
    @Published var timer: Publishers.Autoconnect<Timer.TimerPublisher> = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var showTimesUpPopup: Bool = false
    
    
    // The instance of CMMotionManager responsible for handling sensor updates
    private let motionManager = CMMotionManager()
    
    // Properties to hold the sensor values
    private var gravity: CMAcceleration = CMAcceleration()
    
    var delegate: OCRDelegate?
    
    init() {
        // Set the update interval to any time that you want
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.gyroUpdateInterval = 1.0 / 20.0
        
        startFetchingSensorData()
    }
    
    func getRandomSentence(data: GroupLetterItem) {
        self.data = data
        if let sentences = data.sentences.randomElement() {
            self.sentences = sentences
            
            nextStep()
        }
    }
    
    func nextStep() {
        
        if contentIndex < self.sentences.count {
            isBlankScreen = false
            
            self.sentence = sentences[contentIndex].value
            
            contentIndex += 1
        } else {
            isBlankScreen = true
        }
        
        self.intervalTime = getTimeInterval()
        startTimer()
    }
    
     func startTimer() {
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
        
        let letterCount = self.sentence.count * 2
        
        return Double(letterCount)
    }
    
    func updateTimer() {
        guard hasCountdownCompleted else {
            self.remainingTime -= 1
            return
        }
        
        /// Stop the voice over
        self.stopTimer()
        self.showTimesUpPopup.toggle()
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func sendData() {
        
        if let image = self.capturedImage, let groupLetter = self.data {
           
            
            
            if let newImage = UIImage(color: .white, size: CGSize(width: imageRect.width, height: imageRect.height)){
                if let overlayedImage = newImage.image(byDrawingImage: image, inRect: imageRect){
                    recognizeText(image: overlayedImage) { scanned in
                        print("Result: ", scanned)
                        let handwritinData = HandwritingData(image: image, scannedText: scanned, content: self.sentence, groupLetter: groupLetter, mode: .ipad)
                        self.delegate?.didReceiveOcrData(data: handwritinData)
                        
                        withAnimation {
                            self.isNextScreen = true
                        }
                    }
                }
            }
            
            
            
        }
        
    }
    
    
    
    private func startFetchingSensorData() {
        // Check if the motion manager is available and the sensors are available
        if motionManager.isDeviceMotionAvailable && motionManager.isAccelerometerAvailable && motionManager.isGyroAvailable {
            // Start updating the sensor data
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
                guard let self = self else { return } // Avoid memory leaks
                // Check if there's any error in the sensor update
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                }
                getMotionAndGravity(motion: motion)
            }
        }
    }
    
    private func getMotionAndGravity(motion: CMDeviceMotion?){
        if let motion = motion {
            // Get user acceleration and gravity data
            self.gravity = motion.gravity
            // Update publishers with the new sensor data
            self.gravityValue = "X: \(String(format: "%.2f", gravity.x)), Y: \(String(format: "%.2f", gravity.y)), Z: \(String(format: "%.2f", gravity.z))"
            
            checkSurfacePosition(x: gravity.x, y: gravity.y, z: gravity.z)
        }
    }
    
    func checkSurfacePosition(x: Double, y: Double, z: Double) {
        // X: -1.00 < x < -0.85
        // Y: -0.05 < y < 0.05
        // Z: -0.52 < z < 0.52
        
        if ((-0.85 > x && x > -1.00) && (-0.05 < y && y < 0.05) && (-0.52 < z && z < 0.52)) {
            isSurfacePositionNotValid = false
        } else {
            isSurfacePositionNotValid = true
        }
    }
    
    func recognizeText(image: UIImage, completion: @escaping (String) -> ()) {
        guard let cgImage = image.cgImage else { return }
        let request = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else {
                print("Text recognition error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let scanned = observations.map({ recognizedText in
                recognizedText.topCandidates(1).first?.string ?? ""
            }).joined(separator: " ")
            
            DispatchQueue.main.async {
                completion(scanned)
            }
        }
        request.recognitionLevel = .accurate
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
    
    func didReceivePracticeData(data: Data, image: UIImage) {
        capturedImage = image
        
        print("Image from canvas", image)
        //        groupLetter = data.groupLetter ?? ""
        //        imageResult = data.imageResult
        //        textResult = data.textResult ?? ""
        //
        //        print("check group letter", groupLetter)
    }
    //
    //    func getResult() -> PracticeResult {
    //        return PracticeResult(groupLetter: groupLetter, imageResult: imageResult, textResult: textResult)
    //    }
    //
    //    func getGroupLetter() -> String {
    //        return groupLetter
    //    }
    //
    //    func getImage() -> UIImage {
    //        return imageResult ?? UIImage()
    //    }
    //
    //    func getTextResult() -> String {
    //        return textResult
    //    }
}
