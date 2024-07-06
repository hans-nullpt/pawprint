//
//  PopUpConfirmationClosed.swift
//  pawprint
//
//  Created by Isaac Tambunan on 03/07/24.
//

import SwiftUI

struct PopUpConfirmationClosed: View {
    @Environment(\.dismiss) private var dismiss
    let message: String
    let showCloseButton: Bool
    @Binding var isPresented: Bool
    
    init(message: String, showCloseButton: Bool = false, isPresented: Binding<Bool>) {
        self.message = message
        self.showCloseButton = showCloseButton
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            ZStack(alignment: .topTrailing) {
                VStack(spacing: 48) {
                    Text(message)
                        .font(.system(size: 30).bold())
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 640)
                    
                    HStack(spacing: 120) {
                        Button(action: {
                            isPresented.toggle()
                            dismiss()
                        }) {
                            Text("Yes")
                                .font(.system(size: 30, weight: .bold))
                        }
                        .frame(width: 182, height: 60)
                        .foregroundColor(.white)
                        .background(
                            Image(.scratchBackground)
                                .resizable()
                        )
                        .cornerRadius(.infinity)

                        Button(action: {
                            isPresented.toggle()
                        }) {
                            Text("No")
                                .font(.system(size: 30, weight: .bold))
                        }
                        .frame(width: 182, height: 60)
                        .foregroundColor(.white)
                        .background(
                            Image(.scratchBackgroundRed)
                                .resizable()
                        )
                        .cornerRadius(.infinity)
                    }
                    
                }
                .padding(40)
                .padding(.top, showCloseButton ? 72 : 0)
                .foregroundStyle(.white)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 60))

                
                if showCloseButton {
                    Button(action: {
                        withAnimation {
                            isPresented.toggle()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 44))
                    }
                    .padding(40)
                }
            }
            .frame(maxWidth: 640)
            Image(.catCrying)
                .offset(y: -220)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.6))
                
    }
}

#Preview {
    PopUpConfirmationClosed(message: "Are you sure want to cancel this excercise?", showCloseButton: true, isPresented: .constant(false))
}
