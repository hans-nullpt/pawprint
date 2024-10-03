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
            HistoryListView(device: .whiteboard)
                .tabItem {
                    Label("Whiteboard", systemImage: "pencil.and.scribble")
                }
            
            HistoryListView(device: .ipad)
                .tabItem {
                    Label("iPad", systemImage: "applepencil.and.scribble")
                }
        }
        .accentColor(.black)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
        
    }
    
}

struct HistoryListView: View {
    @Query var histories: [HandwritingHistory]
    
    var device: PracticeModeType
    
    @Environment(\.dismiss) private var dismiss
    
    init(device: PracticeModeType) {
        self.device = device
        
        _histories = Query(filter: #Predicate<HandwritingHistory> { data in
            data.mode == device.rawValue
        }, sort: \HandwritingHistory.timestamp, order: .reverse)
    }
    
    var body: some View {
        NavigationStack {
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
                }.offset(x: 40, y: 32)
                
                ZStack (alignment: .center){
                    Image("HistoryCircle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                    
                    VStack {
                        Text("History")
                            .bold()
                            .font(.system(size: 40))
                        Text("on \(device.rawValue)")
                    }
                }
                
                ZStack {
                    GeometryReader { reader in
                        Image(.historyWhiteboard)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: reader.size.width, maxHeight: reader.size.height * 1)
                            .offset(x: -30, y: -10)
                    }
                    
                    if histories.isEmpty {
                        Text("It looks like you haven't practiced yet. Let's get started!")
                            .font(.system(size: 60))
                            .fontWeight(.medium)
                            .foregroundStyle(.black.opacity(0.4))
                            .frame(maxWidth: 800)
                            .multilineTextAlignment(.center)
                    } else {
                        List {
                            ForEach(histories, id: \.id) { data in
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
                                .listRowBackground(Color.appBackground)
                            }
                        }
                        .listStyle(.plain)
                        .frame(maxWidth: 800, maxHeight: 520)
                    }
                }
                
              
            }
            .background {
                Color("AppBackgroundColor")
                    .ignoresSafeArea(.all)
                Image(.lineBg2)
            }
        }
    }
}


#Preview {
    HistoryView()
}
