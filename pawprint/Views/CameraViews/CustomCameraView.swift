//
//  CustomCameraView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 02/07/24.
//

import SwiftUI

struct CustomCameraView: View {
    let cameraService: CameraHandler = CameraHandler()
    
    @State private var isResultPresented: Bool = false
    @EnvironmentObject private var vm: HandwritingAnalyzeResultViewModel
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .topTrailing) {
                PreviewCameraView(cameraService: cameraService) { result in
                    switch result {
                        
                    case .success(let photo):
                        if let data = photo.fileDataRepresentation() {
                            vm.capturedImage = UIImage(data: data)
                        } else {
                            print("Error: No image data found")
                        }
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
                
                Text("Capture your written sentences \(Image(systemName: "camera.viewfinder"))")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.black.opacity(0.4))
                    .clipShape(Capsule())
                    .offset(y: 48)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button(action: {
                    cameraService.capturePhoto()
                    isResultPresented.toggle()
                }) {
                    ZStack {
                        Circle()
                            .fill(.gray.opacity(0.5))
                            .frame(width: 96, height: 96)
                        Circle()
                            .fill(.white)
                            .frame(width: 64, height: 64)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                .offset(x: -48)
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $isResultPresented) {
                HandwritingAssessmentResultView()
            }
        }
    }
}

#Preview {
    CustomCameraView()
}
