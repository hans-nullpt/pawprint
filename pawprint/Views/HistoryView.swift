//
//  Historyview.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI
import SwiftData

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
    @Query var histories: [HandwritingHistory]
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("AppBackgroundColor")
                    .ignoresSafeArea(.all)
                Image(.lineBg2)
                VStack(alignment: .center) {
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.backward")
                                Text("Back")
                            }
                        }
                        .buttonStyle(PawPrintButtonStyle())
                        Spacer()
                    }.offset(x: 40, y: 0)
                    
                    ZStack (alignment: .center){
                        Image("HistoryCircle")
                            .resizable()
                            .frame(width: 300, height: 100)
                        
                        VStack {
                            Text("History")
                                .bold()
                                .font(.system(size: 40))
                            Text("on iPad")
                        }
                    }
                    
                    ZStack {
                        Image("HistoryWhiteboard")
                            .offset(x: -30, y: -10)
                        
                        ScrollView (showsIndicators: false){
                            VStack(alignment: .leading) {
                                ForEach(histories, id: \.id) { data in
                                    VStack {
                                        HStack {
                                            VStack (alignment: .leading) {
                                                Text(data.letters)
                                                    .fontWeight(.heavy)
                                                    .font(.system(size: 40))
                                                Text(data.type)
                                                    .foregroundColor(Color("darkgray"))
                                                    .font(.system(size: 18))
                                            }
                                            Spacer()
                                            
                                            VStack (alignment: .trailing){
                                                HStack {
                                                    Text("\(String(format: "%.f", data.readibilityPercentage))%")
                                                        .fontWeight(.heavy)
                                                        .font(.system(size: 40))
                                                    Text("Readability")
                                                        .font(.system(size: 36))
                                                }
                                                Text(Date(), style: .date)
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
                        .offset(x: 0, y: 0)
                    }
                }
                
            }
            .navigationBarBackButtonHidden()
            .navigationBarHidden(true)
            .toolbar(.hidden, for: .tabBar)
        }
    }
}


#Preview {
    HistoryView()
}
