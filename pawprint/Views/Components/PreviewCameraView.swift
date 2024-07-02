//
//  PreviewCameraView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 02/07/24.
//

import Foundation
import SwiftUI
import AVFoundation

struct PreviewCameraView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController
    
    let cameraService: CameraHandler
    let didFinishProccessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
    
    func makeUIViewController(context: Context) -> UIViewController {
        
        cameraService.start(delegate: context.coordinator) { err in
            if let err = err {
                didFinishProccessingPhoto(.failure(err))
                
                return
            }
        }
        
        
        let uiViewController = UIViewController()
        
        uiViewController.view.backgroundColor = .black
        cameraService.preview.frame = UIScreen.main.bounds
        cameraService.preview.connection?.videoRotationAngle = 0
        uiViewController.view.layer.addSublayer(cameraService.preview)
        
        return uiViewController
    }
    
    func updateUIViewController(_ uiView: UIViewController, context: Context) {
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, didFinishProccessingPhoto: didFinishProccessingPhoto)
    }
    
    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
        let parent: PreviewCameraView
        private var didFinishProccessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
        
        init(_ parent: PreviewCameraView, didFinishProccessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
            self.parent = parent
            self.didFinishProccessingPhoto = didFinishProccessingPhoto
        }
        func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
            if let error = error {
                didFinishProccessingPhoto(.failure(error))
                
                return
            }
            
            didFinishProccessingPhoto(.success(photo))
        }
    }
    
}
