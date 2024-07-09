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

struct OnBoardingView: View {
//    init() {
//        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("KRedColor"))
//        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("gray"))
//    }
    
    @State private var selectedTab: Int = 0
    @State private var showClosePopup: Bool = false
    @State var groupLetters: String?
    @State var content: [[PracticeSentence]]?
    @State var goToPracticeView: Bool = false
    let tabList = [
        Post(tag: 0, title: "onboard1", label: "First"),
        Post(tag: 1, title: "onboard2", label: "Second"),
        Post(tag: 2, title: "onboard3", label: "Third")
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            Image("line_bg")
            TabView(selection: $selectedTab) {
                ForEach(tabList) { item in
                    ZStack(alignment: .center) {
                        ZStack {
                            Image(item.title)
                                .resizable()
                                .frame(maxWidth: item.label == "First" ? 1200 : 1000, maxHeight: item.label == "First" ? .infinity : 800)
                                .offset(y: item.label == "First" ? 0 : -60)
                            
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
                                    withAnimation {
                                        if (selectedTab < (tabList.count - 1)) {
                                            selectedTab += 1
                                        } else {
                                            goToPracticeView = true
                                        }
                                    }
                                }) {
                                    HStack {
                                        Text(item.tag == (tabList.count - 1) ? "Ready" : "Skip")
                                            .frame(width: 182, height: 40)
                                    }
                                }
                                .buttonStyle(PawPrintButtonStyle())
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }.padding(52)
                        
                        if showClosePopup {
                            PopUpConfirmationClosed(
                                message: "Are you sure want to cancel this excercise?",
                                showCloseButton: true,
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
                            Label(item.label, systemImage: "circle")
                        }
                        .tag(item.tag)
                }
                
                
            }
            .padding(.top, -8)
            .padding(.bottom, -8)
            .accentColor(.red)
        .tabViewStyle(PageTabViewStyle())
        }
        .navigationDestination(isPresented: $goToPracticeView) {
            PracticeView(groupLetters: groupLetters, content: content)
        }
    }
}


//#Preview {
//    OnBoardingView()
//}
