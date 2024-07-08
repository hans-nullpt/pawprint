//
//  DrawingCanvasViewController.swift
//  pawprint
//
//  Created by Isaac Tambunan on 27/06/24.
//

import SwiftUI
import PencilKit

class DrawingCanvasViewController: UIViewController {
    
    let canvasViewId = UUID().uuidString
    let imgRect = CGRect(x: 0, y: 0, width: 400.0, height: 100.0)
    
    lazy var canvas: PKCanvasView = {
        let view = PKCanvasView()
        view.drawingPolicy = .anyInput
        view.minimumZoomScale = 1
        view.maximumZoomScale = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()
    
    var drawingData = Data()
    var drawingChanged: (Data, UIImage) -> Void = {_,_ in}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        NSLayoutConstraint.activate(
            [
                canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                canvas.topAnchor.constraint(equalTo: view.topAnchor),
                canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
//        canvas.delegate = self
        canvas.isOpaque = false
        canvas.layer.opacity = 0.1
        canvas.backgroundColor = UIColor.clear
//        canvas.delegate = context.coordinator
        canvas.becomeFirstResponder()
        
//        let scribbleInteraction = UIScribbleInteraction(delegate: self)
//        canvas.addInteraction(scribbleInteraction)
        
//        let textField = UITextField(frame: canvas.frame)
//        textField.addTarget(self, action: #selector(handleTextFieldDidChange), for: .editingChanged)
//        canvas.addSubview(textField)
        
//        let imageView = UIImageView(image: UIImage(named: "logo"))
//
//        let subView = self.canvas.subviews[0]
//            subView.addSubview(imageView)
//            subView.sendSubviewToBack(imageView)
        
        
//        if let drawing = try? PKDrawing(data: drawingData){
//            canvas.drawing = drawing
//        }
    }
    
}

extension DrawingCanvasViewController:PKToolPickerObserver, PKCanvasViewDelegate{
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        print("Onchanged")
        drawingChanged(canvasView.drawing.dataRepresentation(), canvas.drawing.image(from: canvasView.drawing.bounds, scale: 1))
    }
}

