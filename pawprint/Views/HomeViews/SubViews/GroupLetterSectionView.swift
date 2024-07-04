//
//  GroupLetterSectionView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct GroupLetterSectionView<T>: View {
    var title: String
    var items: [GroupLetterItem<T>]
    
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                .foregroundColor(Color("black"))
                .bold()
                .font(.system(size: 24))
            
            LazyVGrid(columns: columns, spacing: 30) {
                ForEach(items, id: \.id) { item in
                    Button(action: {
                    }) {
                        Text(item.letters.joined(separator: ", "))
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(PawPrintButtonStyle())
                }
            }
        }
    }
}

#Preview {
    GroupLetterSectionView<LowerCaseLetterType>(
        title: "Lowercase",
        items: GroupLetterItem<LowerCaseLetterType>.lowerCaseItems
    )
}
