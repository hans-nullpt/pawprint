//
//  HomeResultView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct HomeResultView: View {
    var data: HandwritingHistory?
    var body: some View {
        if data != nil {
            VStack(spacing: 32) {
                Text("Your last score ")
                    .font(.system(size: 32))
                    .bold()
                + Text(data!.letters)
                    .font(.system(size: 32))
                    .bold()
                    .foregroundColor(.kRed)
                Text("\(String(format: "%.f", data!.readibilityPercentage))%")
                    .font(.system(size: 96))
                    .fontWeight(.heavy)
                    .background {
                        Image(.result)
                            .scaledToFill()
                    }
                Text(data!.readibilityPercentage > 70 ? "Your progress seems great!" : "You need to practice again \nwith this letter group.")
                    .font(.system(size: 28))
                    .bold()
            }
        } else {
            HomeFirstTimeView()
        }
    }
}

#Preview {
    HomeResultView()
}
