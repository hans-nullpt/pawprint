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
    @ObservedObject  var vm: IpadPracticeViewModel
    @StateObject private var resultVm: HandwritingAnalyzeResultViewModel = HandwritingAnalyzeResultViewModel()
    
//    @State var groupLetter: GroupLetterItem
    
    @State private var isTracingMode = false
    @State var leftName = "Tracing"
    @State var rightName = "Line"
    @State var showPopUp = false
    @State var isButtonClicked = false
    
    
    var body: some View {
        NavigationStack{
            ZStack {
                GeometryReader { reader in
                    VStack(alignment: .leading, spacing: 0) {
                        
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("Practice writing the sentences below, then write the letters larger as shown.")
                                    .font(.system(size: 20, weight: .semibold))
                                    .underline()
                                Text(vm.sentence)
                                    .font(.largeTitle)
                                    .fontWeight(.semibold)
                                    .lineLimit(1)
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
                            Text(vm.remainingTime.countdownTimer)
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
                                        .font(.custom("helvetica", fixedSize: 140) .weight(.bold))
                                        .tracking(0)
                                        .foregroundColor(.gray.opacity(0.5))
                                        .offset(y: -14)
                                        .opacity((isTracingMode ? 0 : 1))
                                        .lineSpacing(16)
                                }
                                .frame(
                                    maxWidth: .infinity,
                                    maxHeight: reader.size.height - 90,
                                    alignment: .topLeading)
                                .clipped()
                                
                                // GRID BACKGROUND
                                if isTracingMode {
                                    Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 37) {
                                        
                                        ForEach(0..<3) { _ in
                                            ZStack(alignment: .leading){
                                                VStack {
                                                    VStack {
                                                        Divider().background(.black)
                                                        Spacer()
                                                        Divider()
                                                    }
                                                    .frame(maxHeight: reader.size.height * 0.04)
                                                    
                                                    Spacer()
                                                    
                                                    VStack {
                                                        Divider()
                                                        Spacer()
                                                        Divider().background(.black)
                                                    }
                                                    .frame(maxHeight: reader.size.height * 0.04)
                                                }
                                                .frame(maxHeight: reader.size.height)
                                            }
                                            //                                    .frame(maxHeight: 192, alignment: .leading)
                                            .clipped()
                                        }
                                        
                                    }
                                    .frame(maxWidth: .infinity)
                                }
                            }
                            
                            DrawingCanvasView2(vm: vm) { data, image, rect in
                                vm.imageRect = rect
                                vm.capturedImage = image
                                vm.drawingData = data
                            } canvasViewDidBeginUsingTool: {
                                if !vm.isPracticeStarted {
                                    vm.startTimer()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        //                    .frame(height: 630)
                        .clipped()
                        
                        
                        // BOTTOM COMPONENT
                        Button(action: {
                            if !vm.isBlankScreen {
                                vm.nextStep()
                            } else {
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
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(height: 90)
                        .padding(29)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.white)
                }
                
                
                if !vm.isSurfacePositionNotValid {
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
                        //                            showCloseButton: true,
                        isPresented: $showPopUp
                    )
                    .ignoresSafeArea()
                }
                
                if vm.showTimesUpPopup {
                    PopUpTimesUpView(
                        isPresented: $vm.showTimesUpPopup
                    ) {
                        vm.retryPractice()
                    }
                }
            }
            .onAppear {
                vm.delegate = self.resultVm
                vm.getRandomSentence()
            }
            .toolbar(.hidden, for: .tabBar)
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $vm.isNextScreen) {
                HandwritingAssessmentResultView(vm: resultVm)
            }
            .onDisappear {
                vm.stopTimer()
                vm.data = nil
            }
            .onReceive(vm.timer) { _ in
                withAnimation {
                    vm.updateTimer()
                }
            }
        }
    }
}

#Preview {
    PracticeView(vm: IpadPracticeViewModel())
}
