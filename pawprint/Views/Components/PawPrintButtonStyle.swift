//
//  PawPrintButtonStyle.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 01/07/24.
//

import Foundation
import SwiftUI

struct PawPrintButtonStyle: ButtonStyle {
    
    private var backgroundColor: Color?
    private var foregroundColor: Color?
    
    init() {}
    
    init(backgroundColor: Color, foregroundColor: Color) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 24).bold())
            .padding(.vertical, 16)
            .padding(.horizontal, 32)
            .background( backgroundColor ?? .white )
            .foregroundStyle( foregroundColor ?? .black )
            .clipShape(Capsule())
            .overlay {
                Capsule()
                    .stroke(.black, lineWidth: 4)
            }
    }
    
}
