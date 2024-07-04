//
//  OCRCameraViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import UIKit
import Vision

protocol OCRDelegate {
    func didReceiveOcrData(image: UIImage, scannedText: String)
}

class OCRCameraViewModel: ObservableObject {
    var delegate: OCRDelegate?
    var cameraService: CameraHandler = CameraHandler()
    
    @Published var isResultPresented: Bool = false
    
    func save(image: UIImage) {
        recognizeText(image: image)
        isResultPresented.toggle()
    }
    
    private func recognizeText(image: UIImage) {
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
                self.delegate?.didReceiveOcrData(image: image, scannedText: scanned)
            }
        }
        request.recognitionLevel = .accurate
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
    
}
