//
//  HomeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 02/07/24.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel = HomeViewModel()
    @State private var tab: Int = 0
    
    var body: some View {
        TabView(selection: $vm.tabSelection) {
            DeviceHome(device: .whiteboard)
                .tabItem {
                    
                    Label("Whiteboard", systemImage: "pencil.and.scribble")
                    
                }.tag(0)
            
            DeviceHome(device: .ipad)
                .tabItem {
                    
                    Label("iPad", systemImage: "applepencil.and.scribble")
                    
                }.tag(1)
        }
        .accentColor(.black)
        .environmentObject(vm)
    }
}

struct DeviceHome: View {
    var device: PracticeModeType
    
    @EnvironmentObject private var vm: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading) {
                HStack {
                    if device == .ipad {
                        Image(.iPadIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 74)
                    }
                    else {
                        Image(.whiteboardIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 74)
                    }
                    Spacer()
                    
                    Button(action: {
                    }) {
                        Text("History")
                    }
                    .buttonStyle(PawPrintButtonStyle())
                    
                }
                Spacer()
                HomeResultView()
                    .background {
                        Image(.letspractice)
                            .offset(x: -90)
                    }
                    .frame(maxWidth: .infinity)
                
                Spacer()
                VStack(alignment: .leading, spacing: 2){
                    Text("Choose group letter to start practicing!")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: 36))
                    
                    VStack(spacing: 32){
                        GroupLetterSectionView(
                            title: "Lowercase",
                            items: vm.lowerCaseGroup
                        )
                        
                        GroupLetterSectionView(
                            title: "Uppercase",
                            items: vm.upperCaseGroup
                        )
                    }
                }
            }
            .padding(.horizontal, 84)
            .padding(.vertical, 28)
            .background {
                Color(.appBackground).ignoresSafeArea()
                Image(.lineBg).ignoresSafeArea()
            }
        }.navigationBarHidden(true)
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}
