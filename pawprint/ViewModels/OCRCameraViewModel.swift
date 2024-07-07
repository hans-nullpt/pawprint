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
    var boundingBox: CGRect
}

protocol OCRDelegate {
    func didReceiveOcrData(data: HandwritingData)
}

class OCRCameraViewModel: ObservableObject {
    var delegate: OCRDelegate?
    var cameraService: CameraHandler = CameraHandler()
    
    @Published var isResultPresented: Bool = false
    @Published var capturedImage: UIImage?
    @Published var boundingBox: CGRect?
    
    func save(image: UIImage, groupLetter: GroupLetterItem, selectedContent: String, scannedText: String) {
        if let rotatedImage = image.rotate(radians: -(.pi/2)) {
            recognizeText(image: rotatedImage) { result, bb in
                
                let normalizeRect = self.vnImageRectForNormalizedRect(rect: bb, imageSize: rotatedImage.size)
                if let crop = rotatedImage.cgImage?.cropping(to: normalizeRect) {
                    
                }
                
                let data = HandwritingData(
                    image: rotatedImage, scannedText: scannedText, content: selectedContent, groupLetter: groupLetter,
                    boundingBox: bb
                )
                self.delegate?.didReceiveOcrData(data: data)
                
                withAnimation {
                    self.isResultPresented.toggle()
                }
            }
        }
    }
    
    private func recognizeText(image: UIImage, completion: @escaping (String, CGRect) -> ()) {
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
                let boundingBox = self.getBoundingBox(observations: observations)
                completion(scanned, boundingBox)
            }
        }
        request.recognitionLevel = .accurate
        
        let handler = VNImageRequestHandler(cgImage: cgImage)
        try? handler.perform([request])
    }
    
    private func getBoundingBox(observations: [VNRecognizedTextObservation]) -> CGRect {
        var boundingBoxes: [CGRect] = []
        
        for observation in observations {
            let topCandidate = observation.topCandidates(1)
            
            for candidate in topCandidate {
                let range = candidate.string.startIndex..<candidate.string.endIndex
                
                if let sentenceBox = try? candidate.boundingBox(for: range) {
                    boundingBoxes.append(sentenceBox.boundingBox)
                }
            }
        }
        
        let allWidth = boundingBoxes.map { $0.width }
        let maxWidth = (allWidth.max(by: { $0 < $1 }) ?? 0)
        let height = boundingBoxes.reduce(0) { partialResult, rect in
            partialResult + rect.height
        }
        let x = (boundingBoxes.first?.minX ?? 0)
        let y = 1 - (boundingBoxes.first?.maxY ?? 0) - height
        
        return CGRect(x: x, y: y, width: maxWidth, height: height)
    }
    
    private func vnImageRectForNormalizedRect(rect: CGRect, imageSize: CGSize) -> CGRect {
        let width = imageSize.width
        let height = imageSize.height
        
        let x = rect.minX * width
        let y = rect.maxY * height
        let rectWidth = rect.width * width
        let rectHeight = rect.height * height
        
        return CGRect(x: x, y: y, width: rectWidth, height: rectHeight)
    }
    
}

extension UIImage {
    func rotatedToLandscapeLeft() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = self.size.width
        let height = self.size.height
        
        let rotatedSize = CGSize(width: height, height: width)
        
        UIGraphicsBeginImageContext(rotatedSize)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Move the origin to the middle of the image to rotate around the center.
        context.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
        
        // Rotate the image context by 90 degrees (π/2 radians).
        context.rotate(by: .pi / 2)
        
        // Draw the image into the context, applying the rotation.
        context.scaleBy(x: 1.0, y: -1.0)
        context.draw(cgImage, in: CGRect(x: -height / 2, y: -width / 2, width: height, height: width))
        
        // Get the new rotated image.
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Update the orientation metadata.
        return rotatedImage?.withOrientation(.left)
    }
    
    func withOrientation(_ orientation: UIImage.Orientation) -> UIImage {
        return UIImage(cgImage: self.cgImage!, scale: self.scale, orientation: orientation)
    }
    
    func rotate(radians: CGFloat) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
