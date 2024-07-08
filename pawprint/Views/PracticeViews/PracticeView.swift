//
//  PracticeView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 02/07/24.
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm: IpadPracticeViewModel = IpadPracticeViewModel()
    @StateObject private var resultVm: HandwritingAnalyzeResultViewModel = HandwritingAnalyzeResultViewModel()
    
    @State var id:UUID?
    @State var data:Data?
    @State var groupLetter: GroupLetterItem
    
    @State private var isTracingMode = false
    @State var leftName = "Tracing"
    @State var rightName = "Line"
    @State var showPopUp = false
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
                                Text(vm.sentence)
                                    .font(.system(size: 60, weight: .semibold))
                                    .lineLimit(2)
                            }
                            
                            Spacer()
                            
                            if !vm.isBlankScreen {
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
                                .frame(height: 55)
                            }
                            
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                .background {
                                    Image(.scratchBackground)
                                        .resizable()
                                        .frame(width: 68, height: 68)
                                        .cornerRadius(.infinity)
                                        .scaledToFill()
                                }
                                .clipShape(Circle())
                                .frame(maxWidth: 68, alignment: .topTrailing)
                                .onTapGesture {
                                    withAnimation {
                                        showPopUp.toggle()
                                    }
                                }
                        }
                        .padding(29)
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        // TIMER COMPONENT
                        VStack (alignment: .center) {
                            Text("00:07")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        
                        // CANVAS COMPONENT
                        ZStack(alignment: .top) {
                            if !vm.isBlankScreen {
                                // TRACING BACKGROUND
                                VStack(alignment: .leading) {
                                    Text(vm.sentence)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(3)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("helvetica", fixedSize: 180) .weight(.bold))
                                        .tracking(0)
                                        .foregroundColor(.gray.opacity(0.5))
                                        .offset(y: -14)
                                        .opacity((isTracingMode ? 0 : 1))
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
                                        }.opacity((isTracingMode ? 1 : 0))
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
                                        }.opacity((isTracingMode ? 1 : 0))
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
                                        }.opacity((isTracingMode ? 1 : 0))
                                    }
                                    .frame(maxHeight: 192, alignment: .leading)
                                    .clipped()
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                            
                            //                CANVAS VIEW COMPONENT
                            DrawingCanvasView(groupLetter: groupLetter.letters.joined(separator: ", "), data: data ?? Data(), id: id ?? UUID())
//                                .environment(\.managedObjectContext, viewContext)
//                                .navigationBarTitle(title ?? "Untitled",displayMode: .inline)
                                .cornerRadius(12)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .frame(height: 630)
                        .clipped()
                        
                        
                        // BOTTOM COMPONENT
                        HStack (alignment: .center) {
                            Spacer()
                            Button(action: {
                                if !vm.isBlankScreen {
                                    vm.nextStep()
                                } else {
                                    vm.isNextScreen = true
                                    vm.sendData()
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
                        PopUpConfirmationClosed(
                            message: "Are you sure want to cancel this excercise?",
                            showCloseButton: true,
                            isPresented: $showPopUp
                        )
                        .ignoresSafeArea()
                    }
                }
                
            }
            .onAppear {
                vm.getRandomSentence(data: groupLetter)
                vm.delegate = self.resultVm
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $vm.isNextScreen) {
                HandwritingAssessmentResultView(vm: resultVm)
            }
        }
    }
}

#Preview {
    PracticeView(groupLetter: GroupLetterItem.lowerCaseItems.first!)
}
