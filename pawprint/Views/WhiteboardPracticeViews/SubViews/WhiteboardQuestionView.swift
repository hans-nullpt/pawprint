//
//  WhiteboardingQuestionView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import SwiftUI

struct WhiteboardQuestionView: View {
    @ObservedObject var vm: WhiteboardPracticeViewModel
    
    @State private var showClosePopup: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                Text(vm.remainingTime.countdownTimer)
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
                
//                Spacer()
                
                Text(vm.sentence)
                    .fontWeight(.medium)
                    .font(.system(size: 60))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
                    .background {
                        Image(.question)
                    }
                
//                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("Camera")
                        Image(systemName: "camera")
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 64)
            .padding(.top, 64)
            .padding(.bottom, 32)
            
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
            
            if vm.practiceState == .timesup {
                PopUpConfirmationClosed(
                    message: "Your time is over!",
                    isPresented: $showClosePopup
                )
            }
        }
        .background {
            Color(.appBackground).ignoresSafeArea()
            Image(.lineBg)
        }
        .onReceive(vm.timer!) { _ in
            withAnimation {
                vm.updateTimer()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    WhiteboardQuestionView(vm: WhiteboardPracticeViewModel())
}
