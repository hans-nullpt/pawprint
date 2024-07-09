//
//  FirstOnboardingView.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI

struct FirstOnboarding: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("onboard1")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 900)
                .offset(x: -60, y: 0)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    FirstOnboarding()
}
