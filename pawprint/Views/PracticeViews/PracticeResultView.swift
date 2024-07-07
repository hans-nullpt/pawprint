//
//  PracticeResultView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 06/07/24.
//

import SwiftUI
import SwiftData

struct PracticeResultView: View {
    @StateObject private var vm: PracticeAnalyzeResultViewModel = PracticeAnalyzeResultViewModel()
    @Environment(\.modelContext) private var context
    
    @Query var items: [PracticeResult]
    
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
                            
                            Text("Readability Letters Detail (\(items.count)) On iPad")
                                .font(.system(size: 24))
                                .fontWeight(.medium)
                            
                            Text("e: 4/5 readable,  f: 4/4 readable,  s: 7/8 readable")
                                .font(.system(size: 40))
                                .fontWeight(.medium)
                            
                            HStack{
                                Image(.handwritingExample)
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
                                Image(.redpaw)
                                    .offset(x: 545, y: 120)
                            }
                            
                        }
                        .padding(.vertical, 72)
                        .frame(maxWidth: .infinity)
                    }
                    
                    Spacer()
                    
                    HStack {
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
    
    func addItem() {
        let item = PracticeResult(groupLetter: "", imageResult: "", textResult: "")
        
        context.insert(item)
    }
    
    func updateItem(_ item: PawPrintData) {
        item.name = "practice"
        
        try? context.save()
    }
    
    func deleteItem(_ item: PawPrintData) {
        context.delete(item)
    }
}

//#Preview {
//    PracticeResultView()
//}
