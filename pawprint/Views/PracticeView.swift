//
//  PracticeView.swift
//  pawprint
//
//  Created by Isaac Tambunan on 02/07/24.
//

import SwiftUI

struct PracticeView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State var id:UUID?
    @State var data:Data?
    @State var title:String?
    
    @State private var isTracingMode = false
    @State var leftName = "Tracing"
    @State var rightName = "Line"

    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Practice writing the sentences below, then write the letters larger as shown.")
                        .font(.system(size: 20, weight: .semibold))
                        .underline()
                    Text("effervescent elves")
                        .font(.system(size: 60, weight: .semibold))
                }
                
                Spacer()
                
                ZStack {
                    Capsule()
                        .fill(Color("gray"))
                        .stroke(.black, lineWidth: 2)
                        .frame(width: 300,height: 68)
                        .overlay {
                            Image("toggle_bg")
                                .resizable()
                        }
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isTracingMode.toggle()
                            }
                        }
                    HStack{
                        ZStack{
                            Capsule()
                                .fill(.white)
                                .frame(width: 145,height: 55)
                                .offset(x: isTracingMode ? 148 : 5)
                                .padding()
                            
                            Text("\(leftName)")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(isTracingMode ? .white : .black)
                        }
                        ZStack{
                            Capsule()
                                .fill(.clear)
                                .frame(width: 145,height: 48)
                            Text("\(rightName)")
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(isTracingMode ? .black : .white)
                        }
                    }
                }
                .frame(height: 55)
                
                Button(action: {}) {
                    ZStack {
                        Image("toggle_bg")
                            .resizable()
                            .frame(width: 68, height: 68)
                        Image(systemName: "xmark")
                            .font(.system(size: 36, weight: .heavy, design: .rounded))
                            .foregroundColor(.white)
                    }
                }
                .foregroundColor(.white)
                .cornerRadius(.infinity)
            }
            .padding(29)
            .frame(maxWidth: .infinity)
            
            Divider()
            
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
                Grid(alignment: .leading, horizontalSpacing: 0, verticalSpacing: 37) {
                    ZStack(alignment: .leading){
                        VStack(spacing: 99) {
                            VStack(spacing: 38) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 38) {
                                Divider()
                                Divider().background(.black)
                            }
                        }.opacity(isTracingMode ? 1 : 0)
                        Text("effe_ves_en_")
                            .font(.custom("helvetica", fixedSize: 180) .weight(.bold))
                            .tracking(0)
                            .foregroundColor(.gray.opacity(0.5))
                            .offset(y: -15)
                            .opacity(isTracingMode ? 0 : 1)
                    }
                    .frame(maxHeight: 192, alignment: .leading)
                    .clipped()
                    
                    ZStack(alignment: .leading){
                        VStack(spacing: 99) {
                            VStack(spacing: 38) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 38) {
                                Divider()
                                Divider().background(.black)
                            }
                        }.opacity(isTracingMode ? 1 : 0)
                    }
                    .frame(maxHeight: 180, alignment: .leading)
                    .clipped()
                    
                    ZStack(alignment: .leading){
                        VStack(spacing: 99) {
                            VStack(spacing: 38) {
                                Divider().background(.black)
                                Divider()
                            }
                            VStack(spacing: 38) {
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
//                    .navigationBarTitle(title ?? "Untitled",displayMode: .inline)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // BOTTOM COMPONENT
            HStack (alignment: .center) {
                Spacer()
                Button(action: {}) {
                    ZStack {
                        Image("toggle_bg")
                            .resizable()
                            .frame(width: 182, height: 68)
                        HStack {
                            Text("Next")
                                .font(.system(size: 24, weight: .bold))
                            Image(systemName: "arrow.right")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.white)
                        }.frame(width: 140, height: 40)
                    }
                }
                .foregroundColor(.white)
                .cornerRadius(.infinity)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .padding(29)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

#Preview {
    PracticeView()
}
