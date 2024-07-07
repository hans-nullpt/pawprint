//
//  HandwritingAssessmentResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import SwiftUI

struct HandwritingAssessmentResultView: View {
    @ObservedObject var vm: HandwritingAnalyzeResultViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { reader in
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
                                
                                
                                Text("Readability Letters Detail (\(vm.groupLetter?.letters.joined(separator: ", ") ?? "")) On Whiteboard")
                                    .font(.system(size: 24))
                                    .fontWeight(.medium)
                                
                                Text(vm.letterCountString.joined(separator: ", "))
                                    .font(.system(size: 40))
                                    .fontWeight(.medium)
                                
                                HStack{
                                    
                                    if let image = vm.capturedImage {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(maxWidth: reader.size.width / 2 - 32, maxHeight: 200)
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
                                        .frame(maxWidth: reader.size.width / 2 - 32)
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
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Text("Finish")
                                Image(systemName: "flag.2.crossed")
                            }
                        }
                        .buttonStyle(PawPrintButtonStyle())
                        .frame(maxWidth: .infinity, alignment: .trailing)
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
}

#Preview {
    HandwritingAssessmentResultView(vm: HandwritingAnalyzeResultViewModel())
}
