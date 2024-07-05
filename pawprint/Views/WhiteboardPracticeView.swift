//
//  WhiteboardPracticeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI

struct WhiteboardPracticeView: View {
    @State private var isPracticeStarted = false
    
    var body: some View {
        if isPracticeStarted {
            WhiteboardQuestion()
        }
        else {
            WhiteboarOnboarding()
        }
    }
}
struct WhiteboarOnboarding: View {
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            Image("line_bg")
            Image("onboardingwhiteboard")
                .offset(x: -90, y: -40)
            
            VStack (alignment: .trailing) {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        HStack {
                            Text("Next")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .buttonStyle(PawPrintButtonStyle())
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 116)
            .padding(.vertical, 64)
        }
    }
}

struct WhiteboardQuestion: View {
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            Image("line_bg")
            
            VStack (alignment: .center) {
                Text("00:12")
                    .fontWeight(.heavy)
                    .font(.system(size: 40))
                ZStack {
                    Image("question")
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
        }
    }
}

#Preview {
    WhiteboardPracticeView()
}
