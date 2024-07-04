//
//  Historyview.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI

struct HistoryView: View {
    
    var body: some View {
        TabView {
            FirstTab()
                .tabItem {
                    Label("Whiteboard", systemImage: "pencil.and.scribble")
                }
            
            FirstTab()
                .tabItem {
                    Label("iPad", systemImage: "applepencil.and.scribble")
                }
        }
        .accentColor(.black)
    }
    
}

struct FirstTab: View {
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea(.all)
            Image("line_bg")
            VStack(alignment: .center) {
                HStack {
                    Button(action: {
                    }) {
                        HStack {
                            Image(systemName: "arrow.backward")
                            Text("Back")
                        }
                    }
                    .buttonStyle(PawPrintButtonStyle())
                    Spacer()
                }.offset(x: 40, y: 40)
                
                ZStack (alignment: .center){
                    Image("HistoryCircle")
                    
                    VStack {
                        Text("History")
                            .bold()
                            .font(.system(size: 40))
                        Text("on iPad")
                    }
                }
                    
                ZStack {
                    Image("HistoryWhiteboard")
                        .offset(x: 65, y: 0)
                    
                    ScrollView (showsIndicators: false){
                        VStack(alignment: .leading) {
                            ForEach(1..<10) { index in
                                VStack {
                                    HStack {
                                        VStack (alignment: .leading) {
                                            Text("a,c,d,g,o,q")
                                                .fontWeight(.heavy)
                                                .font(.system(size: 40))
                                            Text("Lowercase")
                                                .foregroundColor(Color("darkgray"))
                                                .font(.system(size: 18))
                                        }
                                        Spacer()
                                        
                                        VStack (alignment: .trailing){
                                            HStack {
                                                Text("80%")
                                                    .fontWeight(.heavy)
                                                    .font(.system(size: 40))
                                                Text("Readability")
                                                    .font(.system(size: 36))
                                            }
                                            Text("Tue, 2 July 2024")
                                                .foregroundColor(Color("darkgray"))
                                                .font(.system(size: 18))
                                        }
                                    }
                                    .padding(.vertical, 20)
                                    .frame(width: 800)
                    
                                    Divider()
                                        .frame(width: 800)
                                }
                            }
                        }
                    }
                    .frame(height: 520)
                    .offset(x: 0, y: -30)
                }
            }
        }
    }
}


#Preview {
    HistoryView()
}
