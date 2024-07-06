//
//  VerticalSurfaceValidationPopUp.swift
//  pawprint
//
//  Created by Isaac Tambunan on 06/07/24.
//

import SwiftUI

struct VerticalSurfaceValidationPopUp: View {
    @Binding var isPresented: Bool
    
    init(isPresented: Binding<Bool>) {
        self._isPresented = isPresented
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("Please place your Ipad vertically using it’s case")
                    .font(.custom("helvetica", fixedSize: 30) .weight(.bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .frame(width: 639, height: 240)
            }
            .padding(.top, 40)
            .padding(.bottom, 40)
            .padding(.leading, 115)
            .padding(.trailing, 115)
            .foregroundStyle(.white)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 60))
            
            Image(.catCrying)
                .offset(y: -220)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black.opacity(0.6))
                
    }
}

#Preview {
    VerticalSurfaceValidationPopUp(isPresented: .constant(false))
}
