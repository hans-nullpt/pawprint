//
//  PracticeViewModel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation
import UIKit

class PracticeAnalyzeResultViewModel: ObservableObject {
    @Published var groupLetter: String = ""
    @Published var imageResult: UIImage?
    @Published var textResult: String = ""
    
    func didReceivePracticeData(data: PracticeResult) {
        groupLetter = data.groupLetter ?? ""
        imageResult = data.imageResult
        textResult = data.textResult ?? ""
        
        print("check group letter", groupLetter)
    }
    
    func getResult() -> PracticeResult {
        return PracticeResult(groupLetter: groupLetter, imageResult: imageResult, textResult: textResult)
    }
    
    func getGroupLetter() -> String {
        return groupLetter
    }
    
    func getImage() -> UIImage {
        return imageResult ?? UIImage()
    }
    
    func getTextResult() -> String {
        return textResult
    }
}
