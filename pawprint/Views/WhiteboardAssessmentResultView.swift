//
//  WhiteboardAssessmentResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import SwiftUI

struct WhiteboardAssessmentResultView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("How Paw see your handwriting")
                .font(.system(size: 48).bold())
            VStack(spacing: 16) {
                Text("Readability")
                    .font(.system(size: 40))
                Text("80%")
                    .font(.system(size: 96))
                    .fontWeight(.heavy)
                Text("effervessent elves swiftly sew")
                    .font(.system(size: 60))
                    .fontWeight(.medium)
                    .padding(16)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                .black,
                                style: StrokeStyle(
                                    lineWidth: 4, dash: [6]
                                )
                            )
                    }
                Text("Others Letter  need to improve is c, m, n.")
                    .font(.system(size: 32))
                    .fontWeight(.medium)
            }
            .padding(.vertical, 72)
            .frame(maxWidth: .infinity)
            .border(.black, width: 16)
            
            Spacer()
            
            HStack {
                Button(action: {}) {
                    HStack {
                        Text("Repeat")
                        Image(systemName: "repeat")
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
                
                Spacer()
                
                Button(action: {}) {
                    HStack {
                        Text("Finish")
                        Image(systemName: "flag.2.crossed")
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
            }
        }
        .padding(.horizontal, 116)
        .padding(.top, 116)
        .padding(.bottom, 16)
    }
}

#Preview {
    WhiteboardAssessmentResultView()
}
