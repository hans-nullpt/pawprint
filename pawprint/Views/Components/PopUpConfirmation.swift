//
//  PopUpConfirmation.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 02/07/24.
//

import SwiftUI

struct PopUpConfirmation<Content: View>: View {
    let message: String
    let showCloseButton: Bool
    let content: () -> Content
    @Binding var isPresented: Bool
    
    init(message: String, showCloseButton: Bool = false, isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.message = message
        self.showCloseButton = showCloseButton
        self._isPresented = isPresented
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 48) {
                    Text(message)
                        .font(.system(size: 30).bold())
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 500)
                    content()
                }
                .padding(.all, 48)
                .padding(.top, showCloseButton ? 72 : 0)
                .padding(.leading, 60)
                .foregroundStyle(.white)
                .background {
                    Image(.scratchBackground)
                        .resizable()
                }
                .clipShape(RoundedRectangle(cornerRadius: 60))
                
                if showCloseButton {
                    Button(action: {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 44))
                            .offset(x: -40, y: 40)
                    }
                }
            }
            .offset(x: 100)
            
            Image(.catAngry)
                .offset(x: -300, y: -20)
            
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.black.opacity(0.6))
    }
}

#Preview {
    PopUpConfirmation(message: "Your size is too small, please make it bigger!", showCloseButton: true, isPresented: .constant(false)) {
        Button("Retry  \(Image(systemName: "repeat"))") {
            
        }
        .buttonStyle(PawPrintButtonStyle())
    }
}
