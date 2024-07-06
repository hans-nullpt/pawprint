//
//  OCRCameraViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import UIKit
import Vision
import SwiftUI

struct HandwritingData {
    var image: UIImage
    var scannedText: String
    var content: String
    var groupLetter: GroupLetterItem
}

protocol OCRDelegate {
    func didReceiveOcrData(data: HandwritingData)
}

class OCRCameraViewModel: ObservableObject {
    var delegate: OCRDelegate?
    var cameraService: CameraHandler = CameraHandler()
    var groupLetter: GroupLetterItem?
    var selectedContent: String?
    
    @Published var isResultPresented: Bool = false
    
    func save(image: UIImage, groupLetter: GroupLetterItem, selectedContent: String) {
        self.groupLetter = groupLetter
        self.selectedContent = selectedContent
        recognizeText(image: image)
        
        withAnimation {
            isResultPresented.toggle()
        }
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
                if let content = self.selectedContent, let groupLetter = self.groupLetter {
                    let data = HandwritingData(
                        image: image, scannedText: scanned, content: content, groupLetter: groupLetter
                    )
                    self.delegate?.didReceiveOcrData(data: data)
                }
            }
        }
        request.recognitionLevel = .accurate
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
    
}
