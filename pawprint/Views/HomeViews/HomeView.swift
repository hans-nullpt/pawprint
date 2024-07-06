//
//  HomeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            DeviceHome(device: "whiteboard")
                .tabItem {
                    Label("Whiteboard", systemImage: "pencil.and.scribble")
                }
            
            DeviceHome(device: "iPad")
                .tabItem {
                    Label("iPad", systemImage: "applepencil.and.scribble")
                }
        }
        .accentColor(.black)
    }
}

struct DeviceHome: View {
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    
    var device: String
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.appBackground).ignoresSafeArea()
                Image(.lineBg)
                ScrollView {
                    VStack (alignment: .leading, spacing: 40) {
                        HStack {
                            if device == "iPad"{
                                Image(.iPadIcon)
                            }
                            else {
                                Image(.whiteboardIcon)
                            }
                            Spacer()
                            
                            Button(action: {
                            }) {
                                Text("History")
                            }
                            .buttonStyle(PawPrintButtonStyle())
                        }.offset(y: 40)
                        
                        HStack (alignment: .center) {
                            ZStack {
                                Image(.letspractice)
                                    .offset(x: -90, y: 25)
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
                    }
                    .padding(.horizontal, 60)
                    .padding(.vertical, 30)
                }
            }
        }.navigationBarHidden(true)
    }
}


#Preview {
    HomeView()
}
