//
//  PawPrintButtonStyle.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import Foundation
import SwiftUI

struct PawPrintButtonStyle: ButtonStyle {
    
    private var background: Image?
    private var foregroundColor: Color?
    
    init() {}
    
    init(background: Image, foregroundColor: Color) {
        self.background = background
        self.foregroundColor = foregroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24).bold())
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background {
                (background ?? Image(.scratchBackground))
                    .resizable()
            }
            .foregroundStyle( foregroundColor ?? .white)
            .clipShape(Capsule())
//            .overlay {
//                Capsule()
//                    .stroke(.black, lineWidth: 4)
//            }
    }
    
}

struct SampleButton: View {
    var body: some View {
        Button("Sample Button") {
            
        }
        .buttonStyle(PawPrintButtonStyle())
            
    }
}

#Preview {
    SampleButton()
}
