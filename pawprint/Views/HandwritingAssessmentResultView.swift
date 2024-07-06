//
//  HandwritingAssessmentResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import SwiftUI

struct HandwritingAssessmentResultView: View {
    @ObservedObject var vm: HandwritingAnalyzeResultViewModel
    
    var body: some View {
        
        NavigationStack {
            ZStack{
                Image(.doodleBackground)
                
                VStack(alignment: .leading) {
                    Text("How Paw see your handwriting")
                        .font(.system(size: 36))
                        .fontWeight(.semibold)
                    ZStack(alignment: .leading) {
                        VStack(spacing: 32) {
                            VStack(spacing: 48){
                                Text("Readability")
                                    .font(.system(size: 40))
                                Text("\(String(format: "%.f", vm.readabilityPercentage))%")
                                    .font(.system(size: 96))
                                    .fontWeight(.heavy)
                                    .overlay {
                                        Image(.result)
                                            .offset(x: 24)
                                    }
                            }
                            
                            
                                Text("Readability Letters Detail (\(vm.groupLetter?.letters.joined(separator: ", ") ?? "")) On iPad")
                                    .font(.system(size: 24))
                                    .fontWeight(.medium)
                                
                                Text("e: 4/5 readable,  f: 4/4 readable,  s: 7/8 readable")
                                    .font(.system(size: 40))
                                    .fontWeight(.medium)
                                
                                HStack{
                                    
                                    if let image = vm.capturedImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: 400, maxHeight: 200)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                            .overlay {
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(
                                                        .red,
                                                        lineWidth: 4
                                                    )
                                                
                                                Canvas { context, size in
                                                    context.stroke(Path(vm.boundingBox), with: .color(.red), lineWidth: 1)
                                                }
                                            }
                                            .onTapGesture {
                                                vm.showImageDetail.toggle()
                                            }
                                    }
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 60))
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text(vm.scannedText)
                                        .font(.system(size: 60))
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.center)
                                        .frame(maxWidth: 400)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                .padding(.horizontal, 32)
                                .padding(.vertical, 24)
                                .frame(maxWidth: .infinity)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            .black,
                                            style: StrokeStyle(
                                                lineWidth: 4, dash: [6]
                                            )
                                        )
                                    Image(.redpaw)
                                        .offset(x: 545, y: 120)
                                }
                            
                            
                        }
                        .padding(.vertical, 72)
                        .frame(maxWidth: .infinity)
                        
                        //                    Image(.catTeaching)
                        //                        .resizable()
                        //                        .scaledToFit()
                        //                        .frame(maxWidth: 256)
                        //                        .offset(x: -20, y: 232)
                    }
                    
                    Spacer()
                    
                    HStack {
                        //                        Button(action: {}) {
                        //                            HStack {
                        //                                Text("Repeat")
                        //                                Image(systemName: "repeat")
                        //                            }
                        //                        }
                        //                        .buttonStyle(PawPrintButtonStyle())
                        
                        Spacer()
                        
                        Button(action: {}) {
                            HStack {
                                Text("Finish")
                                Image(systemName: "flag.2.crossed")
                            }
                        }
                        .buttonStyle(PawPrintButtonStyle())
                    }
                }
                .padding(.horizontal, 116)
                .padding(.vertical, 64)
            }
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
            .sheet(isPresented: $vm.showImageDetail) {
                if let image = vm.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scenePadding()
                }
            }
        }
        
    }
}

#Preview {
    HandwritingAssessmentResultView(vm: HandwritingAnalyzeResultViewModel())
}
