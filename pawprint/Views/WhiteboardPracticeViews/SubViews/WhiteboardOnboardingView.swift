//
//  WhiteboardOnboardingView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import SwiftUI

struct WhiteboardOnboardingView: View {
    @State private var showClosePopup: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack (alignment: .trailing) {
                Image(.onboardingwhiteboard)
                    .offset(x: -90, y: -40)
                
                Button(action: {}) {
                    HStack {
                        Text("Next")
                        Image(systemName: "arrow.right")
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 116)
            .padding(.vertical, 64)
            .background {
                Color(.appBackground).ignoresSafeArea()
                Image(.lineBg)
            }
            
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
                .offset(x: -32, y: 64)
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
        }
    }
}

#Preview {
    WhiteboardOnboardingView()
}
