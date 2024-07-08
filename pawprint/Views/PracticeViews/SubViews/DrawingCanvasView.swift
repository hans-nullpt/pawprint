//
//  DrawingCanvasView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 27/06/24.
//

import SwiftUI
import CoreData
import PencilKit

struct DrawingCanvasView2: UIViewRepresentable {
    
    var completion: (Data, UIImage) -> ()
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let drawing = try? PKDrawing(data: data) {
            canvasView.drawing = drawing
        }
    }
    
    let canvasView: PKCanvasView = {
       let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .pencilOnly
        canvasView.isUserInteractionEnabled = true
        canvasView.backgroundColor = .clear
        canvasView.minimumZoomScale = 1
        canvasView.maximumZoomScale = 1
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.becomeFirstResponder()
        
        return canvasView
    }()
    let canvasView2: PKCanvasView = {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .pencilOnly
        canvasView.isUserInteractionEnabled = true
        canvasView.backgroundColor = .clear
        canvasView.minimumZoomScale = 1
        canvasView.maximumZoomScale = 1
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        canvasView.becomeFirstResponder()
        
        return canvasView
    }()
    let canvasViewId = UUID().uuidString
    var data: Data = Data()
    
    func makeUIView(context: Context) -> some UIView {
        canvasView.delegate = context.coordinator
        canvasView.tool = context.coordinator.drawingTool
        
        let interaction = UIIndirectScribbleInteraction(delegate: context.coordinator)
//        canvasView.addInteraction(interaction)
        
//        canvasView.addInteraction(interaction)
        context.coordinator.setupHiddenTextField(in: canvasView)
        
        if let drawing = try? PKDrawing(data: data) {
            canvasView.drawing = drawing
        }
        
        
        return canvasView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: canvasView, canvasViewId: canvasViewId, canvasViewDrawingDidChange: completion)
    }
}

struct DrawingCanvasView: UIViewControllerRepresentable {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm: IpadPracticeViewModel
    
    func updateUIViewController(_ uiViewController: DrawingCanvasViewController,context: Context) {
        uiViewController.drawingData = data
    }
    typealias UIViewControllerType = DrawingCanvasViewController
    
    var data: Data
    var id: UUID
    
    let viewController = DrawingCanvasViewController()

    
    func makeUIViewController(context: Context) -> DrawingCanvasViewController {
        
        viewController.drawingData = data
        
        
        
//        let indirectScribbleInteraction = UIIndirectScribbleInteraction(delegate: context.coordinator)
//        viewController.canvas.delegate = context.coordinator
//        viewController.canvas.isUserInteractionEnabled = true
//        viewController.canvas.addInteraction(indirectScribbleInteraction)
//        context.coordinator.setupHiddenTextField(in: viewController.canvas)
        ///SAVE DATA WITH COREDATA
        viewController.drawingChanged = { data, image in
            print("check data", data)
            print("check image", image)
            
            vm.didReceivePracticeData(data: data, image: image)
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
    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(canvasView: viewController.canvas, canvasViewId: viewController.canvasViewId) { data in
//                print(
//        }
//    }
//    
//    
}

class Coordinator: NSObject, PKCanvasViewDelegate, UIIndirectScribbleInteractionDelegate {
    
    var canvasView: PKCanvasView
    var canvasViewId: String
    var hiddentTextField: UITextField?
    var drawingTool = PKInkingTool(.pen, color: .black, width: 30)
    var canvasViewDrawingDidChange: (Data, UIImage) -> ()
    
    init(canvasView: PKCanvasView, canvasViewId: String, hiddentTextField: UITextField? = nil, canvasViewDrawingDidChange: @escaping (Data, UIImage) -> ()) {
        self.canvasView = canvasView
        self.canvasViewId = canvasViewId
        self.hiddentTextField = hiddentTextField
        self.canvasViewDrawingDidChange = canvasViewDrawingDidChange
        
        super.init()
    }
    
    func setupHiddenTextField(in view: UIView) {
        hiddentTextField = UITextField(frame: view.layer.frame)
        hiddentTextField?.text = ""
        hiddentTextField?.backgroundColor = UIColor.red
        hiddentTextField?.alpha = 1
        hiddentTextField?.layer.zPosition = -1
        hiddentTextField?.isUserInteractionEnabled = true
        hiddentTextField?.isEnabled = true
        hiddentTextField?.isHidden = true
        
        
        if let subView = hiddentTextField {
            
            subView.addTarget(self, action: #selector(handleTextFieldDidChange(_:)), for: .editingChanged)
            view.addSubview(subView)
        }
    }
    
    @objc
    func handleTextFieldDidChange(_ textField: UITextField) {
        print("Scribble Text: ", textField.text)
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, requestElementsIn rect: CGRect, completion: @escaping ([String]) -> Void) {
        completion([canvasViewId])
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, focusElementIfNeeded elementIdentifier: String, referencePoint focusReferencePoint: CGPoint, completion: @escaping ((UIResponder & UITextInput)?) -> Void) {
        hiddentTextField?.text = ""
        completion(hiddentTextField)
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, frameForElement elementIdentifier: String) -> CGRect {
        return canvasView.bounds
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, isElementFocused elementIdentifier: String) -> Bool {
        return elementIdentifier == canvasViewId
    }
    
    func indirectScribbleInteraction(_ interaction: UIInteraction, shouldDelayFocusForElement elementIdentifier: String) -> Bool {
        return true
    }
    
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
//        print("PPP")
        canvasViewDrawingDidChange(canvasView.drawing.dataRepresentation(), canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1))
    }
    
    func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
//        print(canvasView.drawing.dataRepresentation())
//        completion(canvasView.drawing.dataRepresentation())
//        print("canvasViewDidEndUsingTool")
    }
    
    func canvasViewDidFinishRendering(_ canvasView: PKCanvasView) {
//        print(canvasView.drawing.dataRepresentation())
//        print("canvasViewDidFinishRendering")
    }
    
    func canvasViewDidBeginUsingTool(_ canvasView: PKCanvasView) {
//        print("canvasViewDidBeginUsingTool")
    }
}

