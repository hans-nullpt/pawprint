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
    
    var canvasViewDrawingDidChange: (Data, UIImage, CGRect) -> ()
    var canvasViewDidBeginUsingTool: () -> ()
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
       
        if data.isEmpty {
            print("PKDrawing: ", data)
            canvasView.drawing = PKDrawing()
        }
        
        canvasView.drawing = PKDrawing()
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
    
    let canvasViewId = UUID().uuidString
    @Binding var data: Data
    
    func makeUIView(context: Context) -> some UIView {
        canvasView.delegate = context.coordinator
        canvasView.tool = context.coordinator.drawingTool
        
//        let interaction = UIIndirectScribbleInteraction(delegate: context.coordinator)
//        canvasView.addInteraction(interaction)
        
//        canvasView.addInteraction(interaction)
        context.coordinator.setupHiddenTextField(in: canvasView)
        
        if let window = UIApplication.shared.windows.first {
            let toolPicker = PKToolPicker.shared(for: window)
            toolPicker?.setVisible(true, forFirstResponder: canvasView)
            toolPicker?.addObserver(canvasView)
            toolPicker?.selectedTool = context.coordinator.drawingTool
            canvasView.becomeFirstResponder()
        }
        
        if let drawing = try? PKDrawing(data: data) {
            canvasView.drawing = drawing
        }
        
        
        return canvasView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: canvasView, canvasViewId: canvasViewId, canvasViewDrawingDidChange: canvasViewDrawingDidChange, canvasViewDidBeginUsingTool: canvasViewDidBeginUsingTool)
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
    var canvasViewDrawingDidChange: (Data, UIImage, CGRect) -> ()
    var canvasViewDidBeginUsingTool: () -> ()
    
    init(canvasView: PKCanvasView, canvasViewId: String, hiddentTextField: UITextField? = nil, canvasViewDrawingDidChange: @escaping (Data, UIImage, CGRect) -> (), canvasViewDidBeginUsingTool: @escaping () -> ()) {
        self.canvasView = canvasView
        self.canvasViewId = canvasViewId
        self.hiddentTextField = hiddentTextField
        self.canvasViewDrawingDidChange = canvasViewDrawingDidChange
        self.canvasViewDidBeginUsingTool = canvasViewDidBeginUsingTool
        
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
        
        let image = canvasView.drawing.image(from: canvasView.drawing.bounds, scale: 1)
        let rect = CGRect(x: canvasView.center.x, y: canvasView.center.y, width: canvasView.frame.width, height: canvasView.frame.height)
        
//        if let newImage = UIImage(color: .white, size: CGSize(width: canvasView.frame.width, height: canvasView.frame.height)){
//            if let overlayedImage = newImage.image(byDrawingImage: image, inRect: CGRect(x: canvasView.center.x, y: canvasView.center.y, width: canvasView.frame.width, height: canvasView.frame.height)){
//                canvasViewDrawingDidChange(canvasView.drawing.dataRepresentation(), overlayedImage, rect)
//            }
//        }
//        
        canvasViewDrawingDidChange(canvasView.drawing.dataRepresentation(), image, rect)
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
        canvasViewDidBeginUsingTool()
    }
}

extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    func image(byDrawingImage image: UIImage, inRect rect: CGRect) -> UIImage! {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image.draw(in: rect)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
