//
//  WhiteboardPracticeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI

struct WhiteboardPracticeView: View {
    @StateObject private var vm: WhiteboardPracticeViewModel = WhiteboardPracticeViewModel()
    
    var groupLetter: GroupLetterItem
    
    var body: some View {
        NavigationStack {
            WhiteboardOnboardingView()
                .onAppear {
                    vm.data = groupLetter
                }
        }
        .environmentObject(vm)
    }
}

#Preview {
    WhiteboardPracticeView(groupLetter: GroupLetterItem.lowerCaseItems.first!)
        .environmentObject(WhiteboardPracticeViewModel())
}
