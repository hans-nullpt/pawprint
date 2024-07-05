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
                                Text("80%")
                                    .font(.system(size: 96))
                                    .fontWeight(.heavy)
                                    .overlay {
                                        Image(.result)
                                            .offset(x: 24)
                                    }
                            }
                            
                            Text("Readability Letters Detail (e,f,s) On iPad")
                                .font(.system(size: 24))
                                .fontWeight(.medium)
                            
                            Text("e: 4/5 readable,  f: 4/4 readable,  s: 7/8 readable")
                                .font(.system(size: 40))
                                .fontWeight(.medium)
                            
                            if let image = vm.capturedImage {
                                HStack{
                                    Image(uiImage: image)
                                        .padding()
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(
                                                    .red,
                                                    lineWidth: 4
                                                )
                                        }
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 60))
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text("effervessent elves swiftly sew")
                                        .font(.system(size: 60))
                                        .fontWeight(.medium)
                                        .multilineTextAlignment(.center)
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
                                }
                                
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
        }
    }
}

#Preview {
    HandwritingAssessmentResultView(vm: HandwritingAnalyzeResultViewModel())
}
