//
//  ThirdOnboarding.swift
//  pawprint
//
//  Created by Maria Charlotta on 01/07/24.
//

import SwiftUI

struct ThirdOnboarding: View {
    @EnvironmentObject var vm: IpadPracticeViewModel
    
    @State var showNextPage: Bool = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack{
                Image("onboard3")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 700)
                    .offset(x: -10, y: -10)
                
                Button(action: {
                    showNextPage.toggle()
                }) {
                    HStack {
                        HStack {
                            Text("Start")
                            Image(systemName: "pencil.and.scribble")
                        }
                    }
                }
                .buttonStyle(PawPrintButtonStyle())
                .frame(maxWidth: .infinity, alignment: .trailing)
                .offset(x: -64, y: 64)
            }
        }
        .frame(maxHeight: .infinity)
        .navigationDestination(isPresented: $showNextPage) {
            PracticeView(vm: self.vm)
        }
    }
}

#Preview {
    ThirdOnboarding()
}
