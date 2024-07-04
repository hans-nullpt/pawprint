//
//  HomeResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct HomeResultView: View {
    var body: some View {
        VStack {
            Text("Your last score")
                .font(.system(size: 24))
                .bold()
            Text("e, f, s")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color("KRedColor"))
            ZStack {
                Text("80%")
                    .font(.system(size: 64))
                    .bold()
                Image("result")
                    .resizable()
                    .frame(width: 370, height: 150)
            }
            Text("Your progress seems great!")
                .font(.system(size: 24))
                .bold()
        }
    }
}

#Preview {
    HomeResultView()
}
