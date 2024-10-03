//
//  HomeFirsTimeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 06/07/24.
//

import SwiftUI

struct HomeFirstTimeView: View {
    var body: some View {
        ZStack {
            Text("Lets Practice!!")
                .font(.largeTitle)
                .fontWeight(.heavy)
            Image(.circleletspractice)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 500)
                .offset(y: 15)
        }
    }
}

#Preview {
    HomeFirstTimeView()
}
