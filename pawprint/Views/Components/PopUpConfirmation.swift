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
    
    init(message: String, showCloseButton: Bool = false, @ViewBuilder content: @escaping () -> Content) {
        self.message = message
        self.showCloseButton = showCloseButton
        self.content = content
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 48) {
                    Text(message)
                        .font(.system(size: 30).bold())
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 450)
                    content()
                }
                .padding(.all, 48)
                .padding(.top, 60)
                .padding(.leading, 60)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 60))
                
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.system(size: 44))
                    .offset(x: -24, y: 24)
            }
            
            Image(.catAngry)
                .offset(x: -330, y: -20)
            
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.black.opacity(0.6))
    }
}

#Preview {
    PopUpConfirmation(message: "Your Size is too small, Please make it bigger", showCloseButton: true) {
        Button("ABC Test \(Image(systemName: "abc"))") {
            
        }
        .buttonStyle(PawPrintButtonStyle())
    }
}
