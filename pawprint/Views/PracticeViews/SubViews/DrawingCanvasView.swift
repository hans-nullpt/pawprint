//
//  DrawingCanvasView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 27/06/24.
//

import SwiftUI
import CoreData
import SwiftData

struct DrawingCanvasView: UIViewControllerRepresentable {
//    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var vm: PracticeAnalyzeResultViewModel = PracticeAnalyzeResultViewModel()
    
    @Environment(\.modelContext) private var contexts
    @Query var items: [PracticeResult]
    
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
            
            let item = PracticeResult(groupLetter: "12", imageResult: "13", textResult: "14")
            
            contexts.insert(item)
            
            print("check data item", items.count)
            
//            vm.didReceivePracticeData(data: PracticeResult(groupLetter: groupLetter, imageResult: "image", textResult: ""))
            
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
