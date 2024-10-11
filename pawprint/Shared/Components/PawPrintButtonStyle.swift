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
    private var enableBottomBorder: Bool = false
    
    init() {}
    
    init(background: Image, foregroundColor: Color) {
        self.background = background
        self.foregroundColor = foregroundColor
    }
    
    init(enableBottomBorder: Bool?) {
        self.enableBottomBorder = enableBottomBorder ?? false
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.title3.bold())
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background {
                (background ?? Image(.scratchBackground))
                    .resizable()
            }
            .foregroundStyle( foregroundColor ?? .white)
            .clipShape(Capsule())
            .background {
                if self.enableBottomBorder {
                    Capsule()
                        .stroke(.black, lineWidth: 3)
                        .offset(y: 5)
                }
            }
    }
    
}

struct SampleButton: View {
    var body: some View {
        Button("Sample Button") {
            
        }
        .buttonStyle(PawPrintButtonStyle(enableBottomBorder: true))
            
    }
}

#Preview {
    SampleButton()
}
