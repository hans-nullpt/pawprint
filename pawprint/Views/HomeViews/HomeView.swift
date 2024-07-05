//
//  HomeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    var body: some View {
        let buttonTitles = ["History", "iPad", "Whiteboard"]
        
        ZStack {
            Color(.appBackground).ignoresSafeArea()
            Image(.lineBg)
            ScrollView {
                VStack (alignment: .leading) {
                    HStack (spacing: 20) {
                        ForEach(buttonTitles, id: \.self) { title in
                            Button(action: {
                            }) {
                                Text(title)
                            }
                            .accentColor(.black)
                            .buttonStyle(PawPrintButtonStyle())
                            .padding(.bottom, 10)  // Add some spacing between buttons
                        }
                    }
                    
                    HStack (alignment: .center) {
                        ZStack {
                            Image(.catwithiPad)
                            .offset(x: -110, y: 25)
//                            Image("letspractice")
                            HomeResultView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("Choose group letter to start practicing!")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: 36))
                        .padding(.bottom, 20)
                    
                    GroupLetterSectionView(
                        title: "Lowercase",
                        items: vm.lowerCaseGroup
                    )
                    
                    GroupLetterSectionView(
                        title: "Uppercase",
                        items: vm.upperCaseGroup
                    )
                    
//
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 30)
            }
        }
    }
}
        
#Preview {
    HomeView()
}
