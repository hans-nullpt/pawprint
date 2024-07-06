//
//  WhiteboardingQuestionView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 06/07/24.
//

import SwiftUI

struct WhiteboardQuestionView: View {
    var body: some View {
        ZStack {
            VStack (alignment: .center) {
                Text("00:12")
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
                ZStack {
                    Image(.question)
                    Text("effervescent elves swiftly sew")
                        .fontWeight(.medium)
                        .font(.system(size: 60))
                }
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Text("Camera")
                            Image(systemName: "camera")
                        }
                    }
                    .buttonStyle(PawPrintButtonStyle())
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 116)
            .padding(.vertical, 64)
            .background {
                Color(.appBackground).ignoresSafeArea()
                Image(.lineBg)
            }
        }
    }
}

#Preview {
    WhiteboardQuestionView()
}
