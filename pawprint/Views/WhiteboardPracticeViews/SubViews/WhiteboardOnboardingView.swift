//
//  WhiteboardOnboardingView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import SwiftUI

struct WhiteboardOnboardingView: View {
    @EnvironmentObject private var vm: WhiteboardPracticeViewModel
    @State private var showClosePopup: Bool = false
    @State private var showStartOverlay: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack (alignment: .trailing) {
                Image(.onboardingwhiteboard)
                    .offset(x: -100, y: 40)
                
                Button(action: {
                    withAnimation {
                        showStartOverlay.toggle()
                    }
                }) {
                    HStack {
                        Text("Start")
                        Image(systemName: "pencil.and.scribble")
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(64)
            
            Image(systemName: "xmark")
                .font(.system(size: 24, weight: .heavy, design: .rounded))
                .foregroundColor(.white)
                .padding()
                .background {
                    Image(.scratchBackground)
                        .resizable()
                        .scaledToFill()
                }
                .clipShape(Circle())
                .frame(maxWidth: .infinity, alignment: .topTrailing)
                .offset(x: -64, y: 64)
                .onTapGesture {
                    withAnimation {
                        showClosePopup.toggle()
                    }
                }
            
            if showClosePopup {
                PopUpConfirmationClosed(
                    message: "are you sure want to cancel this excercise? ",
                    isPresented: $showClosePopup
                )
            }
            
            if showStartOverlay {
                PracticeStartOverlay(isPresented: $showStartOverlay)
                    .onDisappear(perform: {
                        withAnimation {
                            vm.isPracticeStarted.toggle()
                        }
                    })
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .background {
            Color(.appBackground).ignoresSafeArea()
            Image(.lineBg)
        }
        .navigationDestination(isPresented: $vm.isPracticeStarted) {
            WhiteboardQuestionView()
        }
    }
}

struct PracticeStartOverlay: View {
    
    @Binding var isPresented: Bool
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let text: [String] = ["Ready!", "Set!", "Write!"]
    
    @State private var count: Int = 0
    
    var body: some View {
        Text(text[count])
            .font(.system(size: 64))
            .fontWeight(.heavy)
            .frame(width: 300, height: 300)
            .background(.white)
            .clipShape(Circle())
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(.black.opacity(0.6))
            .onReceive(timer) { _ in
                guard count > 1 else {
                    withAnimation(.bouncy) {
                        count += 1
                    }
                    return
                }
                
                withAnimation {
                    isPresented = false
                }
                timer.upstream.connect().cancel()
            }
    }
}

#Preview {
   WhiteboardPracticeView(groupLetter: GroupLetterItem.lowerCaseItems.first!)
}
