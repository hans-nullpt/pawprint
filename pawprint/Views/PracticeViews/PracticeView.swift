//
//  PracticeView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 02/07/24.
//

import SwiftUI
import SwiftData

struct PracticeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: PracticeAnalyzeResultViewModel = PracticeAnalyzeResultViewModel()
    
    @Query var items: [PracticeResult]
    
    @State var id:UUID?
    @State var data:Data?
    @State var groupLetters: String?
    @State var content: [[PracticeSentence]]?
    @State var contentIdx = 0
    
    @State private var isTracingMode = false
    @State private var isBlankScreen = false
    @State var leftName = "Tracing"
    @State var rightName = "Line"
    @State var showPopUp = false
    @State var setOffset: CGFloat = 1000
    @State var isButtonClicked = false

    
    var body: some View {
        NavigationStack{
            VStack {
                ZStack {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Practice writing the sentences below, then write the letters larger as shown.")
                                    .font(.system(size: 20, weight: .semibold))
                                    .underline()
                                Text(content?[0][contentIdx].value ?? "")
                                    .font(.system(size: 60, weight: .semibold))
                            }
                            
                            Spacer()
                            
                            ZStack {
                                Capsule()
                                    .fill(Color("gray"))
                                    .stroke(.black, lineWidth: 2)
                                    .frame(width: 300,height: 68)
                                    .overlay {
                                        Image(.scratchBackground)
                                            .resizable()
                                    }
                                    .cornerRadius(.infinity)
                                    .onTapGesture {
                                        withAnimation(.easeOut) {
                                            isTracingMode.toggle()
                                        }
                                    }
                                HStack{
                                    ZStack{
                                        Capsule()
                                            .fill(.white)
                                            .frame(width: 145,height: 55)
                                            .offset(x: isTracingMode ? 148 : 5)
                                            .padding()
                                        
                                        Text("\(leftName)")
                                            .font(.system(size: 24, weight: .regular))
                                            .foregroundColor(isTracingMode ? .white : .black)
                                    }
                                    ZStack{
                                        Capsule()
                                            .fill(.clear)
                                            .frame(width: 145,height: 48)
                                        Text("\(rightName)")
                                            .font(.system(size: 24, weight: .regular))
                                            .foregroundColor(isTracingMode ? .black : .white)
                                    }
                                }
                            }
                            .opacity(isBlankScreen ? 0 : 1)
                            .frame(height: 55)
                            
                            Button(action: {
                                showPopUp.toggle()
                                setOffset = 1000
                            }) {
                                ZStack {
                                    Image(.scratchBackground)
                                        .resizable()
                                        .frame(width: 68, height: 68)
                                    Image(systemName: "xmark")
                                        .font(.system(size: 36, weight: .heavy, design: .rounded))
                                        .foregroundColor(.white)
                                }
                            }
                            .foregroundColor(.white)
                            .cornerRadius(.infinity)
                        }
                        .padding(29)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        // TIMER COMPONENT
                        VStack (alignment: .center) {
                            Text("00:07 :: \(items.count)")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        // CANVAS COMPONENT
                        ZStack(alignment: .top) {
                            // TRACING BACKGROUND
                            VStack(alignment: .leading) {
                                //                            Text("effe_ves_en_")
                                Text(content?[0][contentIdx].value ?? "")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom("helvetica", fixedSize: 180) .weight(.bold))
                                    .tracking(0)
                                    .foregroundColor(.gray.opacity(0.5))
                                    .offset(y: -14)
                                    .opacity(isBlankScreen ? 0 : (isTracingMode ? 0 : 1))
                                    .lineSpacing(16)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                            .clipped()
                            
                            // GRID BACKGROUND
                            Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 37) {
                                ZStack(alignment: .leading){
                                    VStack(spacing: 99) {
                                        VStack(spacing: 38) {
                                            Divider().background(.black)
                                            Divider()
                                        }
                                        VStack(spacing: 38) {
                                            Divider()
                                            Divider().background(.black)
                                        }
                                    }.opacity(isBlankScreen ? 0 : (isTracingMode ? 1 : 0))
                                }
                                .frame(maxHeight: 192, alignment: .leading)
                                .clipped()
                                
                                ZStack(alignment: .leading){
                                    VStack(spacing: 99) {
                                        VStack(spacing: 38) {
                                            Divider().background(.black)
                                            Divider()
                                        }
                                        VStack(spacing: 38) {
                                            Divider()
                                            Divider().background(.black)
                                        }
                                    }.opacity(isBlankScreen ? 0 : (isTracingMode ? 1 : 0))
                                }
                                .frame(maxHeight: 180, alignment: .leading)
                                .clipped()
                                
                                ZStack(alignment: .leading){
                                    VStack(spacing: 99) {
                                        VStack(spacing: 38) {
                                            Divider().background(.black)
                                            Divider()
                                        }
                                        VStack(spacing: 38) {
                                            Divider()
                                            Divider().background(.black)
                                        }
                                    }.opacity(isBlankScreen ? 0 : (isTracingMode ? 1 : 0))
                                }
                                .frame(maxHeight: 192, alignment: .leading)
                                .clipped()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            //                CANVAS VIEW COMPONENT
                            DrawingCanvasView(groupLetter: groupLetters ?? "", data: data ?? Data(), id: id ?? UUID())
                                .environment(\.managedObjectContext, viewContext)
                            //                    .navigationBarTitle(title ?? "Untitled",displayMode: .inline)
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(height: 630)
                        .clipped()
                        
                        // BOTTOM COMPONENT
                        HStack (alignment: .center) {
                            Spacer()
//                            NavigationLink(destination: PracticeResultView(vm: PracticeAnalyzeResultViewModel())) {
                                Button(action: {
                                    if (contentIdx < ((content?[0].count ?? 1) - 1)) {
                                        isBlankScreen = false
                                        contentIdx += 1
                                    } else {
                                        if isBlankScreen {
                                        } else {
                                            isBlankScreen = true
                                        }
                                    }
                                }) {
                                    HStack {
                                        Text("Next")
                                            .font(.system(size: 24, weight: .bold))
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 24, weight: .bold, design: .rounded))
                                            .foregroundColor(.white)
                                    }
                                }
                                .buttonStyle(PawPrintButtonStyle())
//                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                        .padding(29)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    
                    if vm.isSurfacePositionNotValid {
                        VerticalSurfaceValidationPopUp(isPresented: $vm.isSurfacePositionNotValid)
                            .ignoresSafeArea()
                            .offset(x:0, y: 0)
                            .onAppear{
                                withAnimation(.spring()) {
                                }
                            }
                    }
                    
                    if showPopUp {
                        PopUpConfirmationClosed(message: "Are you sure want to cancel this excercise?", showCloseButton: true, isPresented: $showPopUp)
                            .ignoresSafeArea()
                            .offset(x:0, y: setOffset)
                            .onAppear{
                                withAnimation(.spring()) {
                                    setOffset = 0
                                }
                            }
                    }
                }
                
            }
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $isBlankScreen) {
                PracticeResultView()
            }
        }
        .modelContainer(for: PracticeResult.self, inMemory: true)
    }
}

//#Preview {
//    PracticeView()
//}
