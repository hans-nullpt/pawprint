//
//  HomeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 02/07/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        let buttonTitles = ["History", "iPad", "Whiteboard"]
        let lowerCase: [[String: String]] = [
            ["label": "a,c,d,g,o,q", "id": "1"],
            ["label": "i,j,l,t,u", "id": "2"],
            ["label": "b,h,k,l", "id": "3"],
            ["label": "m,n,r,v,w", "id": "4"],
            ["label": "v,w,x,z", "id": "5"],
            ["label": "e,f,s", "id": "6"]
        ]
        
        let upperCase: [[String: String]] = [
            ["label": "C,G,O,Q", "id": "1"],
            ["label": "I,J,L,T,U", "id": "2"],
            ["label": "B,D,F,H,K,L", "id": "3"],
            ["label": "B,P,R,S", "id": "4"],
            ["label": "A,K,M,N,V,W,X,Y,Z", "id": "5"],
            ["label": "M,N,V,W", "id": "6"]
        ]
        
        let columns = [
            GridItem(.flexible(), spacing: 30),
            GridItem(.flexible(), spacing: 30),
            GridItem(.flexible()),
        ]
        
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            Image("line_bg")
            ScrollView {
                VStack (alignment: .leading) {
                    HStack (spacing: 20) {
                        ForEach(buttonTitles, id: \.self) { title in
                            Button(action: {
                            }) {
                                Text(title)
                            }
                            .accentColor(.black)
                            .buttonStyle(PawPrintButtonStyle())
                            .padding(.bottom, 10)  // Add some spacing between buttons
                        }
                    }
                    
                    HStack (alignment: .center) {
                        ZStack {
                            Image("catwithiPad")
                            .offset(x: -110, y: 25)
//                            Image("letspractice")
                            ResultHomeView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    
                    Text("Choose group letter to start practicing!")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: 36))
                        .padding(.bottom, 20)
                    
                    Text("Lowercase")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: 24))
                    
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(lowerCase, id: \.self) { item in
                            if let label = item["label"], let _ = item["id"] {
                                Button(action: {
                                }) {
                                    Text(label)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                }
                                .buttonStyle(PawPrintButtonStyle())
                            }
                        }
                    }
                    
                    Text("Uppercase")
                        .foregroundColor(Color("black"))
                        .bold()
                        .font(.system(size: 24))
                    
                    LazyVGrid(columns: columns, spacing: 30) {
                        ForEach(upperCase, id: \.self) { item in
                            if let label = item["label"], let _ = item["id"] {
                                Button(action: {
                                }) {
                                    Text(label)
                                        .frame(maxWidth: .infinity) // Make the button full width
                                        .padding()
                                }
                                .buttonStyle(PawPrintButtonStyle())
                            }
                        }
                    }
                }
                .padding(.horizontal, 60)
                .padding(.vertical, 30)
            }
        }
    }
}

struct ResultHomeView: View {
    var body: some View {
        VStack {
            Text("Your last score")
                .font(.system(size: 24))
                .bold()
            Text("e, f, s")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(Color("KRedColor"))
            ZStack {
                Text("80%")
                    .font(.system(size: 64))
                    .bold()
                Image("result")
                    .resizable()
                    .frame(width: 370, height: 150)
            }
            Text("Your progress seems great!")
                .font(.system(size: 24))
                .bold()
        }
    }
}
        
#Preview {
    HomeView()
}
