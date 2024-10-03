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
    @State private var showHistory: Bool = false
    
    var body: some View {
        NavigationStack {
            TabView(selection: $vm.tabSelection) {
                DeviceHome(device: .whiteboard, showHistory: $showHistory)
                    .tabItem {
                        
                        Label("Whiteboard", systemImage: "pencil.and.scribble")
                        
                    }.tag(0)
                
                DeviceHome(device: .ipad, showHistory: $showHistory)
                    .tabItem {
                        
                        Label("iPad", systemImage: "applepencil.and.scribble")
                        
                    }.tag(1)
            }
            .accentColor(.black)
            .environmentObject(vm)
            .navigationDestination(isPresented: $showHistory) {
                HistoryView()
            }
        }
        .navigationBarHidden(true)
    }
}

struct DeviceHome: View {
    var device: PracticeModeType
    
    @Query var histories: [HandwritingHistory]
    @Binding var showHistory: Bool
    @EnvironmentObject private var vm: HomeViewModel
    @EnvironmentObject private var soundVm: SoundViewModel
    
    @AppStorage("background_music") private var isSoundActive: Bool = false
    
    init(device: PracticeModeType, showHistory: Binding<Bool>) {
        self.device = device
        self._showHistory = showHistory
        
        _histories = Query(filter: #Predicate<HandwritingHistory> { data in
            data.mode == device.rawValue
        }, sort: \HandwritingHistory.timestamp, order: .reverse)
    }
    
    var body: some View {
//        NavigationStack {
        GeometryReader { reader in
            VStack (alignment: .leading) {
                HStack {
                    if device == .ipad {
                        Image(.iPadIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: reader.size.width * 0.05)
                    }
                    else {
                        Image(.whiteboardIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: reader.size.width * 0.05)
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
                                    .font(.title3)
                            } else {
                                Image(systemName: "speaker.slash")
                                    .font(.title3)
                            }
                            
                        }
                        .contentTransition(.symbolEffect(.replace))
                        .frame(width: 56, height: 56)
                        .foregroundStyle(.white)
                        .background {
                            Image(.scratchBackground)
                        }
                        .clipShape(Circle())
                        
                        Button(action: {
                            showHistory.toggle()
                        }) {
                            Text("History")
                        }
                        .buttonStyle(PawPrintButtonStyle())
                    }
                    
                }
                Spacer()
                HomeResultView(data: histories.first)
                    .background {
                        Image(.letspractice)
                            .resizable()
                            .scaledToFill()
                            .frame(height: reader.size.height * 0.3)
                            .offset(x: -(reader.size.width * 0.05))
                    }
                    .frame(maxWidth: .infinity)
                
                Spacer()
                VStack(alignment: .leading, spacing: 2){
                    Text("Choose group letter to start practicing!")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: reader.size.width * 0.025))
                    
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
            .onAppear {
                if isSoundActive {
                    soundVm.playSound(sound: .pawprintsound)
                }
            }
        }
//        }
//        .navigationBarHidden(true)
//        .onAppear {
//            if isSoundActive {
//                soundVm.playSound(sound: .pawprintsound)
//            }
//        }
    }
}


#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
        .environmentObject(SoundViewModel.musicInstance)
}
