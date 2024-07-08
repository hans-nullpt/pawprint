//
//  HomeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 02/07/24.
//

import SwiftUI
import SwiftData

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
    
    @Query var histories: [HandwritingHistory]
    var device: PracticeModeType
    
    @EnvironmentObject private var vm: HomeViewModel
    @EnvironmentObject private var soundVm: SoundViewModel
    
    @AppStorage("background_music") private var isSoundActive: Bool = false
    
    init(device: PracticeModeType) {
        self.device = device
        
        _histories = Query(filter: #Predicate<HandwritingHistory> { data in
            data.mode == device.rawValue
        }, sort: \HandwritingHistory.timestamp, order: .reverse)
    }
    
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
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                isSoundActive.toggle()
                                
                                if isSoundActive {
                                    soundVm.playSound(sound: .pawprintsound)
                                } else {
                                    soundVm.stopSound()
                                }
                            }
                        } ) {
                            if isSoundActive {
                                Image(systemName: "speaker.wave.2")
                                    .font(.title)
                            } else {
                                Image(systemName: "speaker.slash")
                                    .font(.title)
                            }

                        }
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 64, height: 64)
                        .foregroundStyle(.white)
                        .background {
                            Image(.scratchBackground)
                        }
                        .clipShape(Circle())
                        
                        NavigationLink(destination: HistoryView()) {
                            Text("History")
                        }
                        .buttonStyle(PawPrintButtonStyle())
                    }
                    
                }
                Spacer()
                HomeResultView(data: histories.first)
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
        }
        .navigationBarHidden(true)
        .onAppear {
            if isSoundActive {
                soundVm.playSound(sound: .pawprintsound)
            }
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(SoundViewModel.musicInstance)
}
