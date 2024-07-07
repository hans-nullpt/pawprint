//
//  PracticeViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import UIKit
import CoreMotion

class PracticeAnalyzeResultViewModel: ObservableObject {
    @Published var groupLetter: String = ""
    @Published var imageResult: String = ""
    @Published var textResult: String = ""
    @Published var gravityValue: String = ""
    @Published var isSurfacePositionNotValid: Bool = true
    
    // The instance of CMMotionManager responsible for handling sensor updates
    private let motionManager = CMMotionManager()
    
    // Properties to hold the sensor values
    private var gravity: CMAcceleration = CMAcceleration()
    
    init() {
        // Set the update interval to any time that you want
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz
        motionManager.accelerometerUpdateInterval = 1.0 / 60.0
        motionManager.gyroUpdateInterval = 1.0 / 20.0
        
        startFetchingSensorData()
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
    
    func didReceivePracticeData(data: PracticeResult) {
        groupLetter = data.groupLetter ?? ""
        imageResult = data.imageResult ?? ""
        textResult = data.textResult ?? ""
        
        print("check group letter", groupLetter)
    }
    
}
