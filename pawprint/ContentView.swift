//
//  ContentView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 25/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isSplashActive: Bool = true
    var body: some View {
        if isSplashActive {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeOut) {
                            isSplashActive.toggle()
                        }
                    }
                }
        } else {
            HomeView()
        }
    }
}

//#Preview {
//    ContentView()
//}
