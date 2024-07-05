//
//  HomeViewMOdel.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    var lowerCaseGroup: [GroupLetterItem] = GroupLetterItem.lowerCaseItems
    var upperCaseGroup: [GroupLetterItem] = GroupLetterItem.upperCaseItems
}
