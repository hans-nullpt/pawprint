//
//  DataScannerView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import Foundation
import VisionKit
import SwiftUI

protocol DataScannerDelegate {
    func didCapture(image: UIImage, recognizedItems: [RecognizedItem])
}

class CaptureButtonView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Outer circle
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderWidth = 6.0
        self.layer.borderColor = UIColor.white.cgColor
        self.backgroundColor = .white
        
        // Inner circle
        let innerCircle = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width * 0.6, height: self.frame.size.height * 0.6))
        innerCircle.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        innerCircle.layer.cornerRadius = innerCircle.frame.size.width / 2
        innerCircle.backgroundColor = .red
        
        self.addSubview(innerCircle)
    }
}

class CanvasView: UIView {
    // Array of CGRects to draw
    var rects: [CGRect] = []
    
    // Only override draw() if you perform custom drawing.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        // Set drawing parameters
        context.setStrokeColor(UIColor.systemYellow.cgColor)
        context.setLineWidth(2.0)
        
        // Draw rectangles
        for rect in rects {
            context.stroke(rect)
        }
    }
}

class DataScannerViewControllerWrapper: UIViewController, DataScannerViewControllerDelegate {
    private var recognizedItems: [RecognizedItem] = []
    
    var scannerController: DataScannerViewController!
    var dataScannerDelegate: DataScannerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataScannerViewController()
    }
    
    let captureButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 72/2
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let innerCircle = UIView()
        innerCircle.backgroundColor = .white
        innerCircle.layer.cornerRadius = 56 / 2
        innerCircle.translatesAutoresizingMaskIntoConstraints = false
        innerCircle.isUserInteractionEnabled = false
        button.addSubview(innerCircle)
        
        NSLayoutConstraint.activate([
            innerCircle.widthAnchor.constraint(equalToConstant: 56),
            innerCircle.heightAnchor.constraint(equalToConstant: 56),
            innerCircle.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            innerCircle.centerYAnchor.constraint(equalTo: button.centerYAnchor)
        ])
        
        return button
    }()
    
    
    func setupDataScannerViewController() {
        scannerController = DataScannerViewController(
            recognizedDataTypes: [.text(textContentType: .none)],
            qualityLevel: .accurate,
            recognizesMultipleItems: true,
            isHighFrameRateTrackingEnabled: true,
            isGuidanceEnabled: false,
            isHighlightingEnabled: true
        )
            
        scannerController.delegate = self
        
        let roiRect = CGRect(
            x: 256 / 2,
            y: view.frame.size.height / 4 ,
            width: view.frame.size.width - 256,
            height: view.frame.size.height / 2
        )
        scannerController.regionOfInterest = roiRect
        
        let canvasView = CanvasView()
        canvasView.frame = view.bounds
        canvasView.backgroundColor = .clear
        
        canvasView.rects = [roiRect]
        
        scannerController.overlayContainerView.addSubview(canvasView)
        
        addChild(scannerController)
        view.addSubview(scannerController.view)
        scannerController.didMove(toParent: self)
        
        scannerController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scannerController.view.topAnchor.constraint(equalTo: view.topAnchor),
            scannerController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scannerController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scannerController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.addSubview(captureButton)
        
        // Set constraints
        NSLayoutConstraint.activate([
            captureButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            captureButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            captureButton.widthAnchor.constraint(equalToConstant: 72),
            captureButton.heightAnchor.constraint(equalToConstant: 72)
        ])
        
        
        // Set the initial state of the button
        captureButton.isEnabled = true
        captureButton.addTarget(self, action: #selector(scanButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func scanButtonTapped() {
        print("Scan button tapped!")
        Task {
            do {
                let photo = try await scannerController.capturePhoto()
                
                dataScannerDelegate?.didCapture(image: photo, recognizedItems: recognizedItems)
            }
        }
    }
    
    //    func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
    //    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        
        recognizedItems.append(contentsOf: addedItems)
        
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
//        if let item = recognizedItem, removedItems.contains(where: { $0.id == item.id }) {
//            print("Item: \(item.id) removed")
//            recognizedItem = nil
//        }
        
        for item in removedItems {
            recognizedItems = recognizedItems.filter { $0.id != item.id }
        }
    }
    
    func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
        print("Scanner; Unavailable")
    }
    
}

struct DataScannerViewControllerRepresentable: UIViewControllerRepresentable {
    
    let completion: (UIImage?, [RecognizedItem]) -> ()
    
    func makeUIViewController(context: Context) -> DataScannerViewControllerWrapper {
        let controller = DataScannerViewControllerWrapper()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewControllerWrapper, context: Context) {
        uiViewController.dataScannerDelegate = context.coordinator
        try? uiViewController.scannerController.startScanning()
    }
    
    // Coordinator Pattern (optional for delegation)
    class Coordinator: NSObject, DataScannerDelegate {
        private var completion: (UIImage?, [RecognizedItem]) -> ()
        
        init(completion: @escaping(UIImage?, [RecognizedItem]) -> ()) {
            self.completion = completion
        }
        
        func didCapture(image: UIImage, recognizedItems: [RecognizedItem]) {
            print("Gambar: \(image)")
            completion(image, recognizedItems)
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completion: completion)
    }
}

struct DataScannerView: UIViewControllerRepresentable {
    @Binding var recognizedItem: [RecognizedItem]
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let controller = DataScannerViewController(
            recognizedDataTypes: [.text(textContentType: .none)],
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isGuidanceEnabled: false,
            isHighlightingEnabled: true
        )
        
        let button = UIButton()
        button.setTitle("Hai", for: .normal)
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItem: $recognizedItem)
    }
    
    static func dismantleUIViewController(_ uiViewController: DataScannerViewController, coordinator: Coordinator) {
        uiViewController.stopScanning()
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        @Binding var recognizedItem: [RecognizedItem]
        
        init(recognizedItem: Binding<[RecognizedItem]>) {
            self._recognizedItem = recognizedItem
        }
        
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn: \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItem.append(contentsOf: addedItems)
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItem = recognizedItem.filter { item in !removedItems.contains(where: { $0.id == item.id }) }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Scanner; Unavailable")
        }
        
        
    }
}

