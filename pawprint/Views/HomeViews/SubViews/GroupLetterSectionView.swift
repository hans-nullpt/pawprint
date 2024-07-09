//
//  GroupLetterSectionView.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import SwiftUI

struct GroupLetterSectionView: View {
    @EnvironmentObject private var vm: HomeViewModel
    
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
                    
                    NavigationLink {
                        if vm.tabSelection == 0 {
                            WhiteboardPracticeView(groupLetter: item)
                        } else {
                            IpadOnBoardingView(groupLetter: item, goToPracticeView: false)
//                            PracticeView(groupLetter: item)
                        }
                    } label: {
                        Text(item.letters.joined(separator: ", "))
                            .frame(maxWidth: .infinity)
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
    .environmentObject(HomeViewModel())
}
