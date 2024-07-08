//
//  HandwritingAnalyzeResultViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import Foundation
import UIKit
import Vision

class HandwritingAnalyzeResultViewModel: ObservableObject, OCRDelegate {
    @Published var instructionSentence: String = ""
    @Published var showCameraModal = false
    @Published var scannedText: AttributedString = AttributedString()
    @Published var capturedImage: UIImage?
    @Published var wordsResults: [WordResult] = []
    @Published var readabilityPercentage: Double = 0
    @Published var groupLetter: GroupLetterItem?
    @Published var showImageDetail: Bool = false
    @Published var letterCount: [LetterCount] = []
    @Published var letterCountString: [String] = []
    
    func didReceiveOcrData(data: HandwritingData) {
        self.capturedImage = data.image
        self.instructionSentence = data.content
        self.groupLetter = data.groupLetter
        self.processAnaylze(scanned: data.scannedText.split(separator: "\n").joined(separator: " "))
        
        recognizeText(image: data.image) { scanned in
            print("Scanned: ", scanned)
        }
    }
    
    private func recognizeText(image: UIImage, completion: @escaping (String) -> ()) {
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
    
    func processAnaylze(scanned: String) {
        /// Split the text String
        let contentSplit = instructionSentence.split(separator: " ")
        let scannedSplit = scanned.split(separator: " ")
        
        /// Only process if both splitted text are the same length
        guard contentSplit.count == scannedSplit.count else {
            return
        }
        
        let results = zip(contentSplit, scannedSplit).map { content, scanned in
            /// Check if the length are same
            if (content.count == scanned.count) {
                /// Check the value equality
                if (content == scanned) {
                    /// Example: jaded <> jaded
                    let results = scanned.map { scan in
                        WordAnalyzeResult(value: String(scan), actualLetter: String(scan))
                    }
                    return WordResult(value: String(scanned), results: results)
                } else {
                    /// Example: jaded <> jades or zombies <> sombres
                    
                    /// Split each word into array of letter/character
                    let contentLetters = content.split(separator: "")
                    let scannedLetters = scanned.split(separator: "")
                    
                    let results = zip(contentLetters, scannedLetters).map { content, scanned in
                        
                        /// If error, then return result contains letter error
                        guard content == scanned else {
                            return WordAnalyzeResult(
                                value: String(scanned),
                                actualLetter: String(content),
                                isError: true,
                                error: .letterError
                            )
                        }
                        
                        return WordAnalyzeResult(value: String(scanned), actualLetter: String(content))
                    }
                    
                    /// return word result that contains error
                    return WordResult(value: String(scanned), hasError: true, results: results)
                }
            } else {
                /// Example: jaded <> jade or jaded <> jadeds
                
                /// Check if the scanned length greater than content length, then define as word error
                guard scanned.count > content.count else {
                    /// return result contains word error
                    let results = zip(scanned, content).map { scannedLetter, contentLetter  in
                        if !content.contains(scannedLetter) {
                            WordAnalyzeResult(
                                value: String(scannedLetter),
                                actualLetter: String(contentLetter),
                                isError: true,
                                error: .letterError
                            )
                        } else {
                            WordAnalyzeResult(
                                value: String(scannedLetter),
                                actualLetter: String(contentLetter),
                                isError: true,
                                error: .wordError
                            )
                        }
                    }
                    
                    return WordResult(value: String(scanned), hasError: true, results: results)
                }
                
                /// Otherwise, check each letter equality
                var results: [WordAnalyzeResult] = []
                for (_, letter) in scanned.enumerated() {
                    
                    if !content.contains(letter) {
                        /// If content doesnt contains the letter, then return result with letter error
                        results.append(WordAnalyzeResult(
                            value: String(letter),
                            actualLetter: String(content),
                            isError: true, 
                            error: .letterError
                        ))
                    } else {
                        /// Otherwise, true
                        results.append(WordAnalyzeResult(value: String(letter), actualLetter: String(content)))
                    }
                    
                }
                
                /// return word result that contains error
                return WordResult(value: String(scanned), hasError: true, results: results)
            }
        }
        
        buildSentenceHighlighter(results: results)
        checkReadabilityPercentage(results: results)
        getLetterCount(results: results)
    }
    
    func buildSentenceHighlighter(results: [WordResult]) {
        
        let items = results.map { result in
            /// Check is the result has error or not
            guard result.hasError else {
                /// Otherwise, return AttributedString
                return AttributedString(result.value)
            }
            
            /// Transform the result into AttributedString
            let item = result.results.map { item in
                /// If error, create AttributedString with highlighter
                if item.isError {
                    var errText = item.error == .letterError ? AttributedString(" \(item.value) ") : AttributedString("\(item.value)")
                    errText.foregroundColor = .black
                    errText.backgroundColor = item.error == .letterError ? .red.opacity(0.5) : .yellow
                    
                    return errText
                } else {
                    /// Otherwise return AttributedString
                    return AttributedString(item.value)
                }
            }.reduce(AttributedString(), { prev, item in prev + item })
            
            return item
        }
        
        self.scannedText = items.reduce(AttributedString(), { prev, item in prev + AttributedString(" ") + item })
    }
    
    func checkReadabilityPercentage(results: [WordResult]) {
        let percentage = results.reduce(0) { prev, item in
            
            let correct = item.results.filter({ !($0.isError) })
            
            return prev + (Double(correct.count) / Double(item.value.count) * 100 )
        } / Double(results.count)
        
        self.readabilityPercentage = round(percentage)
    }
    
    func getLetterCount(results: [WordResult]) {
        guard groupLetter != nil else {
            return
        }
        
        let actualLetterResults = results.flatMap { result in
            let actualLetter = result.results.compactMap { item in
                if groupLetter!.letters.contains(item.actualLetter) {
                    return item
                }
                
                return nil
            }
            
            return actualLetter
        }
        
        self.letterCount = groupLetter!.letters.map { letter in
            LetterCount(
                value: letter,
                total: actualLetterResults.filter { $0.actualLetter == letter }.count,
                error: actualLetterResults.filter { $0.actualLetter == letter && $0.error == .letterError }.count
            )
        }
        
        self.letterCountString = self.letterCount.map { item in
            "\(item.value): \(item.total - item.error)/\(item.total) readable"
        }
    }
}
