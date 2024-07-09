//
//  OnBoardingOverlay.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI

struct Post : Identifiable{
    let id = UUID()
    let tag: Int
    let title: String
    let label: String
}

struct IpadOnBoardingView: View {
    
    @State private var currentIndex: Int = 0
    @State private var showClosePopup: Bool = false
    var groupLetter: GroupLetterItem
    @State var goToPracticeView: Bool = false
    @StateObject private var vm: IpadPracticeViewModel = IpadPracticeViewModel()
    let tabList = [
        Post(tag: 0, title: "onboard1", label: "First"),
        Post(tag: 1, title: "onboard2", label: "Second"),
        Post(tag: 2, title: "onboard3", label: "Third")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackgroundColor")
                    .ignoresSafeArea()
                Image("line_bg")
                
                ZStack(alignment: .center) {
                    ZStack {
                        Image(tabList[currentIndex].title)
                            .resizable()
                            .frame(maxWidth: tabList[currentIndex].label == "First" ? 1200 : 1000, maxHeight: tabList[currentIndex].label == "First" ? .infinity : 800)
                            .offset(y: tabList[currentIndex].label == "First" ? 0 : -60)
                        
                        VStack (alignment: .trailing) {
                            Image(systemName: "xmark")
                                .font(.system(size: 24, weight: .heavy, design: .rounded))
                                .foregroundColor(.white)
                                .padding()
                                .background {
                                    Image(.scratchBackground)
                                        .resizable()
                                        .scaledToFill()
                                }
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, alignment: .topTrailing)
                                .onTapGesture {
                                    withAnimation {
                                        showClosePopup.toggle()
                                    }
                                }
                            Spacer()
                            Button(action: {
                                    if (currentIndex < (tabList.count - 1)) {
                                        withAnimation(.linear) {
                                            currentIndex += 1
                                        }
                                    } else {
                                        withAnimation {
                                            goToPracticeView = true
                                        }
                                    }
                            }) {
                                HStack {
                                    Text(tabList[currentIndex].tag == (tabList.count - 1) ? "Start" : "Next")
                                    
                                    Image(systemName: tabList[currentIndex].tag == (tabList.count - 1) ? "pencil.and.scribble" : "arrow.right")
                                }
                            }
                            .buttonStyle(PawPrintButtonStyle())
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }.padding(52)
                    
                    if showClosePopup {
                        PopUpConfirmationClosed(
                            message: "Are you sure want to cancel this excercise?",
                            isPresented: $showClosePopup
                        )
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .navigationBarBackButtonHidden()
                .navigationBarHidden(true)
                .toolbar(.hidden, for: .tabBar)
                .background {
                    Color(.appBackground).ignoresSafeArea()
                    Image(.lineBg)
                }
                .tabItem {
                    Label(tabList[currentIndex].label, systemImage: "circle")
                }
                .tag(tabList[currentIndex].tag)
                
                .padding(.top, -8)
                .padding(.bottom, -8)
                .accentColor(.red)
            }
            .frame(maxHeight: .infinity)
            .navigationDestination(isPresented: $goToPracticeView) {
                PracticeView(vm: self.vm)
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onAppear {
            vm.data = groupLetter
        }
        .environmentObject(vm)
    }
}


//#Preview {
//    IpadOnBoardingView()
//}
