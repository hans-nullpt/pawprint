//
//  DrawingCanvasView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 27/06/24.
//

import SwiftUI

struct DrawingCanvasView: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm: PracticeAnalyzeResultViewModel = PracticeAnalyzeResultViewModel()
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewController,context: Context) {
        uiViewController.drawingData = data
    }
    typealias UIViewControllerType = DrawingCanvasViewController
    
    var groupLetter: String
    var data: Data
    var id: UUID
    
    func makeUIViewController(context: Context) -> DrawingCanvasViewController {
        let viewController = DrawingCanvasViewController()
        viewController.drawingData = data
        
        ///SAVE DATA WITH COREDATA
        viewController.drawingChanged = {data, image in
            print("check data", data)
            print("check image", image)
            
            vm.didReceivePracticeData(data: PracticeResult(groupLetter: groupLetter, imageResult: image, textResult: ""))
//            let request: NSFetchRequest<Drawing> = Drawing.fetchRequest()
//            let predicate = NSPredicate(format: "id == %@", id as CVarArg)
//            request.predicate = predicate
//            do{
//                let result = try viewContext.fetch(request)
//                let obj = result.first
//                obj?.setValue(data, forKey: "canvasData")
//                do{
//                    try viewContext.save()
//                }
//                catch{
//                    print(error)
//                }
//            }
//            catch{
//                print(error)
//            }
        }
        return viewController
    }
}
