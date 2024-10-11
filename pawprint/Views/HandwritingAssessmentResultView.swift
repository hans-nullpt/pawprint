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
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        NavigationStack {
            GeometryReader { reader in
                ScrollView {
                    VStack(spacing: 32) {
                        
                        Text("How Paw see your handwriting")
                            .font(.system(size: 36))
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        
                        Text("Readability")
                            .font(.system(size: 40))
                        Text("\(String(format: "%.f", vm.readabilityPercentage))%")
                            .font(.system(size: 96))
                            .fontWeight(.heavy)
                            .overlay {
                                Image(.result)
                                    .offset(x: 24)
                            }
                        
                        
                        Text("Readability Letters Detail (\(vm.groupLetter?.letters.joined(separator: ", ") ?? "")) On \(vm.mode.rawValue)")
                            .font(.system(size: 24))
                            .fontWeight(.medium)
                        
                        Text(vm.letterCountString.joined(separator: ", "))
                            .font(.system(size: 36))
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        if let image = vm.capturedImage, vm.scannedText != AttributedString(){
                            HStack{
                                
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: reader.size.width / 2 - 32, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                .kRed,
                                                lineWidth: 4
                                            )
                                    }
                                    .onTapGesture {
                                        vm.showImageDetail.toggle()
                                    }
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 60))
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Text(vm.scannedText)
                                    .font(.system(size: 48))
                                    .fontWeight(.medium)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: reader.size.width / 2 - 32)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding()
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(
                                                .black,
                                                lineWidth: 4
                                            )
                                    }
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 24)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                ZStack(alignment: .bottomTrailing) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(
                                            .black,
                                            style: StrokeStyle(
                                                lineWidth: 4, dash: [6]
                                            )
                                        )
                                    Image(.redpaw)
                                        .offset(x: 64, y: 64)
                                }
                            }
                            .onAppear {
                                
                                if let groupLetter = vm.groupLetter {
                                    
                                    let data = HandwritingHistory(
                                        sentence: vm.instructionSentence,
                                        letters: groupLetter.letters.joined(separator: ", "),
                                        type: groupLetter.type.rawValue,
                                        readibilityPercentage: vm.readabilityPercentage,
                                        timestamp: Date.now,
                                        mode: vm.mode
                                    )
                                    
                                    print("Saving the data")
                                    
                                    context.insert(data)
                                    
                                    do {
                                        try context.save()
                                    } catch {
                                        print("Error: \(error.localizedDescription)")
                                    }
                                }
                                
                                
                            }
                        } else {
                            Text("Uh ohh! Paw can not analyze your handwriting")
                                .font(.system(size: 48))
                                .fontWeight(.medium)
                                .padding(.horizontal, 24)
                                .padding(.bottom, 64)
                                .padding(.top, 72)
                                .frame(maxWidth: .infinity)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .overlay {
                                    Image(.catCrying)
                                        .offset(y: -160)
                                }
                                .background {
                                    ZStack(alignment: .bottomTrailing) {
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(.white)
                                            .strokeBorder(Color.black, lineWidth: 4)
                                        
                                        Image(.redpaw)
                                            .offset(x: 64, y: 64)
                                    }
                                }
                                .offset(y: 140)
                        }
                        
                        
                    }
                    .padding(.horizontal, 118)
                    .padding(.vertical, 48)
                    
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
                    .padding(.horizontal, 118)
                    .padding(.vertical, 48)
                    .padding(.top, 118)
                }
                
                
            }
            .background {
                Image(.doodleBackground)
            }
            .navigationBarBackButtonHidden()
            .toolbar(.hidden, for: .tabBar)
            .sheet(isPresented: $vm.showImageDetail) {
                if let image = vm.capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .scenePadding()
                        .border(.black)
                }
            }
        }
        
    }
}

#Preview {
    HandwritingAssessmentResultView(vm: HandwritingAnalyzeResultViewModel())
}
