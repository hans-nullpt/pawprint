//
//  WhiteboardPracticeView.swift
//  pawprint
//
//  Created by Maria Charlotta on 04/07/24.
//

import SwiftUI

struct WhiteboardPracticeView: View {
    @State private var isPracticeStarted = false
    
    var body: some View {
        NavigationStack {
            if isPracticeStarted {
                WhiteboardQuestionView()
                    .navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
            }
            else {
                WhiteboardOnboardingView()
                    .navigationBarBackButtonHidden()
                    .navigationBarHidden(true)
                    .toolbar(.hidden, for: .tabBar)
            }
        }
    }
}

#Preview {
    WhiteboardPracticeView()
}
