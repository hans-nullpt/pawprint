//
//  ContentView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 25/06/24.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    
    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    
    @State private var isTracingMode = false
    @State var leftName = "Tracing"
    @State var rightName = "Line"

    
    var body: some View {
        VStack(alignment: .trailing, spacing: 0) {

            ZStack{
                Capsule()
                    .fill(Color("gray"))
                    .stroke(.black, lineWidth: 2)
                    .frame(width: 200,height: 50)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isTracingMode.toggle()
                        }
                    }
                HStack{
                    ZStack{
                        Capsule()
                            .fill(.white)
                            .frame(width: 93,height: 48)
                            .offset(x: isTracingMode ? 107 : 0)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 50)
//                                    .stroke(isTracingMode ? .clear : .black, lineWidth: 1)
//                            )
                            .padding()
                        
                        Text("\(leftName)")
                    }
                    ZStack{
                        Capsule()
                            .fill(.clear)
                            .frame(width: 98,height: 48)
                        Text("\(rightName)")
                    }
                }
            }
            
            // TIMER COMPONENT
            VStack (alignment: .center) {
                Text("00:07")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
            // CANVAS COMPONENT
            ZStack(alignment: .top) {
                // GRID BACKGROUND
                Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 56) {
                    ZStack(alignment: .leading){
                        VStack(spacing: 110) {
                            VStack(spacing: 40) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 40) {
                                Divider()
                                Divider().background(.black)
                            }
                        }.opacity(isTracingMode ? 1 : 0)
                        Text("effe_ves_en_")
                            .font(.system(size: 195, weight: .bold))
                            .tracking(0)
                            .foregroundColor(.gray.opacity(0.5))
                            .offset(y: -18)
                            .opacity(isTracingMode ? 0 : 1)
                    }
                    .frame(maxHeight: 192, alignment: .leading)
                    .clipped()
                    
                    ZStack(alignment: .leading){
                        VStack(spacing: 110) {
                            VStack(spacing: 40) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 40) {
                                Divider()
                                Divider().background(.black)
                            }
                        }.opacity(isTracingMode ? 1 : 0)
//                        // TRACING COMPONENT
//                        Text("effervescent")
//                            .font(.system(size: 195, weight: .bold))
//                            .tracking(0)
//                            .foregroundColor(.gray.opacity(0.5))
//                            .offset(y: -18)
                    }
                    .frame(maxHeight: 192, alignment: .leading)
                    .clipped()
                    
                    ZStack(alignment: .leading){
                        VStack(spacing: 110) {
                            VStack(spacing: 40) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 40) {
                                Divider()
                                Divider().background(.black)
                            }
                        }.opacity(isTracingMode ? 1 : 0)
                    }
                    .frame(maxHeight: 192, alignment: .leading)
                    .clipped()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
//                CANVAS VIEW COMPONENT
                DrawingCanvasView(data: data ?? Data(), id: id ?? UUID())
                    .environment(\.managedObjectContext, viewContext)
                    .navigationBarTitle(title ?? "Untitled",displayMode: .inline)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // BOTTOM COMPONENT
            HStack (alignment: .center) {
                Button(action: {}) {
                    VStack {
                      Text("Cancel")
                        .padding(.horizontal)
                    }.frame(width: 140, height: 40)
                }
                .padding()
                .background(Color("gray"))
                .foregroundColor(.black)
                .cornerRadius(14)
                
                Spacer()
                
                Button(action: {}) {
                    VStack {
                      Text("Next")
                        .padding(.horizontal)
                    }.frame(width: 140, height: 40)
                }
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .padding(24)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    ContentView()
}
