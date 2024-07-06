//
//  GroupLetterSectionView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct GroupLetterSectionView: View {
    var title: String
    var items: [GroupLetterItem]
    
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
            
            LazyVGrid(columns: columns, spacing: 14) {
                ForEach(items, id: \.id) { item in
                    
                    NavigationLink(destination: PracticeView(groupLetters: item.letters.joined(separator: ", "), content: item.sentences)) {
                        Text(item.letters.joined(separator: ", "))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .toolbar(.hidden, for: .tabBar)
                    }
                    .buttonStyle(PawPrintButtonStyle(enableBottomBorder: true))
                    
                }
            }
        }
    }
}

#Preview {
    GroupLetterSectionView(
        title: "Lowercase",
        items: GroupLetterItem.lowerCaseItems
    )
}
