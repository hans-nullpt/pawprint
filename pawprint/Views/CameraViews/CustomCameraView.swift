//
//  CustomCameraView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 02/07/24.
//

import SwiftUI

struct CustomCameraView: View {
    @StateObject private var vm: OCRCameraViewModel = OCRCameraViewModel()
    @StateObject private var resultVm: HandwritingAnalyzeResultViewModel = HandwritingAnalyzeResultViewModel()
    
    var groupLetter: GroupLetterItem
    var selectedContent: String
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .topTrailing) {
                DataScannerViewControllerRepresentable { image, recognizedItems in
                    
                    if let image = image {
                        vm.save(
                            image: image,
                            groupLetter: groupLetter,
                            selectedContent: selectedContent,
                            recognizedItems: recognizedItems
                        )
                    }
                }
                //                PreviewCameraView(cameraService: vm.cameraService) { result in
                //                    switch result {
                //
                //                    case .success(let photo):
                //                        if let data = photo.fileDataRepresentation(), let image = UIImage(data: data) {
                //                            vm.save(
                //                                image: image,
                //                                groupLetter: groupLetter,
                //                                selectedContent: selectedContent
                //                            )
                //                        }
                //                    case .failure(let error):
                //                        print("Error: \(error.localizedDescription)")
                //                    }
                //                }
                
                Text("Capture your written sentences \(Image(systemName: "camera.viewfinder"))")
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(.black.opacity(0.4))
                    .clipShape(Capsule())
                    .offset(y: 48)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                //                Button(action: {
                //                    vm.cameraService.capturePhoto()
                //                }) {
                //                    ZStack {
                //                        Circle()
                //                            .fill(.gray.opacity(0.5))
                //                            .frame(width: 96, height: 96)
                //                        Circle()
                //                            .fill(.white)
                //                            .frame(width: 64, height: 64)
                //                    }
                //                }
                //                .frame(maxHeight: .infinity, alignment: .center)
                //                .offset(x: -48)
            }
            .ignoresSafeArea()
            .navigationDestination(isPresented: $vm.isResultPresented) {
                HandwritingAssessmentResultView(vm: resultVm)
            }
            .onAppear {
                self.vm.delegate = resultVm
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    CustomCameraView(
        groupLetter: GroupLetterItem.lowerCaseItems.first!,
        selectedContent: "Ini test content"
    )
}
