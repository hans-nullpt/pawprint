//
//  WhiteboardPracticeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI

struct WhiteboardPracticeView: View {
    @EnvironmentObject private var vm: WhiteboardPracticeViewModel
    
    var groupLetter: GroupLetterItem
    
    var body: some View {
        NavigationStack {
            WhiteboardOnboardingView()
                .onAppear {
                    vm.data = groupLetter
                }
        }
    }
}

#Preview {
    WhiteboardPracticeView(groupLetter: GroupLetterItem.lowerCaseItems.first!)
        .environmentObject(WhiteboardPracticeViewModel())
}
