//
//  SecondOnboarding.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI

struct SecondOnboarding: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("onboard2")
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 700)
                .offset(x: -10, y: -10)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    SecondOnboarding()
}
