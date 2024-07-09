//
//  OnBoardingOverlay.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI

struct IpadOnBoardingView: View {
    
    var groupLetter: GroupLetterItem
    
    @State var showClosePopUp: Bool = false
    @State var showPracticePage: Bool = false
    @StateObject private var vm: IpadPracticeViewModel = IpadPracticeViewModel()
    
    init(groupLetter: GroupLetterItem) {
        self.groupLetter = groupLetter
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color("KRedColor"))
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color("gray"))
    }
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            Image("line_bg")
            TabView {
                FirstOnboarding()
                    .tabItem {
                        Label("First", systemImage: "circle")
                    }
                SecondOnboarding()
                    .tabItem {
                        Label("Second", systemImage: "circle")
                    }
                ThirdOnboarding(showNextPage: $showPracticePage)
                    .tabItem {
                        Label("Third", systemImage: "circle")
                    }
            }
            .padding(.bottom, 30)
            .accentColor(.red)
            .tabViewStyle(PageTabViewStyle())
            
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
                .offset(x: -64, y: 64)
                .onTapGesture {
                    withAnimation {
                        showClosePopUp.toggle()
                    }
                }
            
            if showClosePopUp {
                PopUpConfirmationClosed(
                    message: "are you sure want to cancel this excercise? ",
                    isPresented: $showClosePopUp
                )
            }
        }
        .onAppear {
            vm.data = groupLetter
        }
        .frame(maxHeight: .infinity)
        .navigationBarBackButtonHidden()
        .navigationBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .environmentObject(vm)
        .navigationDestination(isPresented: $showPracticePage) {
            PracticeView(vm: self.vm)
        }
    }
}


#Preview {
    IpadOnBoardingView(groupLetter: GroupLetterItem.lowerCaseItems.first!)
}
