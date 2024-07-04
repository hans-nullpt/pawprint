//
//  SplashView.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI
import Lottie

struct SplashView: View {
    var body: some View {
        ZStack(alignment:.top) {
            LottieView(animation: .named("splashscreen.json"))
                .playing(loopMode: .loop)
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SplashView()
}
