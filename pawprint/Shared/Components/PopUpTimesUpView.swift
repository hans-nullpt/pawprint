//
//  PopUpTimesUpView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import SwiftUI

struct PopUpTimesUpView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    
    var onRetry: () -> ()
    
    var body: some View {
        ZStack(alignment: .top) {
            
            
            VStack(spacing: 48) {
                Text("Your time is up!")
                    .font(.system(size: 30).bold())
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 640)
                
                HStack(spacing: 88) {
                    
                    
                    Button(action: {
                        isPresented.toggle()
                        dismiss()
                    }) {
                        Text("No")
                            .font(.system(size: 30, weight: .bold))
                            .frame(width: 160)
                    }
                    .buttonStyle(
                        PawPrintButtonStyle(
                            background: Image(.scratchBackgroundRed),
                            foregroundColor: .white
                        )
                    )
                    
                    Button(action: {
                        isPresented.toggle()
                        onRetry()
                    }) {
                        Text("Retry")
                            .font(.system(size: 30, weight: .bold))
                            .frame(width: 160)
                    }
                    .buttonStyle(
                        PawPrintButtonStyle(
                            background: Image(.scratchBackground),
                            foregroundColor: .white
                        )
                    )
                }
                
            }
            .padding(40)
            .padding(.top, 48)
            .foregroundStyle(.white)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 60))
            
            
            
            Image(.catCrying)
                .offset(y: -190)
        }
        .frame(maxWidth: 640)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.6))
        
    }
}

#Preview {
    PopUpTimesUpView(isPresented: .constant(false)) {
        
    }
}
