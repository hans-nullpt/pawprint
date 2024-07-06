//
//  HomeResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct HomeResultView: View {
    var body: some View {
        VStack(spacing: 32) {
            Text("Your last score ")
                .font(.system(size: 32))
                .bold()
            + Text("e, f, s")
                .font(.system(size: 32))
                .bold()
                .foregroundColor(.kRed)
            Text("80%")
                .font(.system(size: 96))
                .fontWeight(.heavy)
                .background {
                    Image(.result)
                        .scaledToFill()
                }
            Text("Your progress seems great!")
                .font(.system(size: 28))
                .bold()
        }
    }
}

#Preview {
    HomeResultView()
}
