//
//  GroupLetter.swift
//  pawprint
//
//  Created by Ivan Nur Ilham Syah on 04/07/24.
//

import Foundation

struct PracticeSentence: Hashable {
    var step: String
    var value: String
}

enum LowerCaseLetterType: CaseIterable {
    case acdgoq
    case ijlt
    case bhkp
    case mnrvu
    case ywxz
    case efs
    
    var description: [String] {
        switch (self) {
            
        case .acdgoq:
            return ["a", "c", "d", "g", "o", "q"]
        case .ijlt:
            return ["i", "j", "l", "t"]
        case .bhkp:
            return ["b", "h", "k", "p"]
        case .mnrvu:
            return ["m", "n", "r", "v", "u"]
        case .ywxz:
            return ["y", "w", "x", "z"]
        case .efs:
            return ["e", "f", "s"]
        }
    }
    
    var sentences: [[PracticeSentence]] {
        switch (self) {
            
        case .acdgoq:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "cats and"),
                    PracticeSentence(step: "Practice 2", value: "cats and dogs often"),
                    PracticeSentence(step: "Practice 3", value: "cats and dogs often quarrel"),
                    PracticeSentence(step: "Practice 4", value: "cats and dogs often quarrel over food")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "the magician"),
                    PracticeSentence(step: "Practice 2", value: "the magician acquired"),
                    PracticeSentence(step: "Practice 3", value: "the magician acquired a golden"),
                    PracticeSentence(step: "Practice 4", value: "the magician acquired a golden cloak")
                ],
                [
                    /// Sentences 3
                    PracticeSentence(step: "Practice 1", value: "quick"),
                    PracticeSentence(step: "Practice 2", value: "quick dogs"),
                    PracticeSentence(step: "Practice 3", value: "quick dogs chased"),
                    PracticeSentence(step: "Practice 4", value: "quick dogs chased the agile")
                ],
                [
                    /// Sentences 4
                    PracticeSentence(step: "Practice 1", value: "good coaches"),
                    PracticeSentence(step: "Practice 2", value: "good coaches can quickly"),
                    PracticeSentence(step: "Practice 3", value: "good coaches can quickly guide"),
                    PracticeSentence(step: "Practice 4", value: "good coaches can quickly guide any team")
                ],
                [
                    /// Sentences 5
                    PracticeSentence(step: "Practice 1", value: "dogs quickly"),
                    PracticeSentence(step: "Practice 2", value: "dogs quickly darted"),
                    PracticeSentence(step: "Practice 3", value: "dogs quickly darted across"),
                    PracticeSentence(step: "Practice 4", value: "dogs quickly darted across the garden")
                ]
            ]
        case .ijlt:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "jill"),
                    PracticeSentence(step: "Practice 2", value: "jill just"),
                    PracticeSentence(step: "Practice 3", value: "jill just lit the"),
                    PracticeSentence(step: "Practice 4", value: "jill just lit the little light.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "tilt"),
                    PracticeSentence(step: "Practice 2", value: "tilt the jar"),
                    PracticeSentence(step: "Practice 3", value: "tilt the jar till it"),
                    PracticeSentence(step: "Practice 4", value: "tilt the jar till it jiggles.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "i just"),
                    PracticeSentence(step: "Practice 2", value: "i just love"),
                    PracticeSentence(step: "Practice 3", value: "i just love jill's"),
                    PracticeSentence(step: "Practice 4", value: "i just love jill's little jokes.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "jill will"),
                    PracticeSentence(step: "Practice 2", value: "jill will jilt"),
                    PracticeSentence(step: "Practice 3", value: "jill will jilt tim,"),
                    PracticeSentence(step: "Practice 4", value: "jill will jilt tim, just wait.")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "little jill"),
                    PracticeSentence(step: "Practice 2", value: "little jill jilted"),
                    PracticeSentence(step: "Practice 3", value: "little jill jilted tim"),
                    PracticeSentence(step: "Practice 4", value: "little jill jilted tim twice.")
                ]
            ]
        case .bhkp:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "phil"),
                    PracticeSentence(step: "Practice 2", value: "phil baked"),
                    PracticeSentence(step: "Practice 3", value: "phil baked a big"),
                    PracticeSentence(step: "Practice 4", value: "phil baked a big pink cake.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "hank"),
                    PracticeSentence(step: "Practice 2", value: "hank kept"),
                    PracticeSentence(step: "Practice 3", value: "hank kept a book by"),
                    PracticeSentence(step: "Practice 4", value: "hank kept a book by his bed.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "the kid"),
                    PracticeSentence(step: "Practice 2", value: "the kid picked"),
                    PracticeSentence(step: "Practice 3", value: "the kid picked up a broken"),
                    PracticeSentence(step: "Practice 4", value: "the kid picked up a broken bat.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "beth parks"),
                    PracticeSentence(step: "Practice 2", value: "beth parks her"),
                    PracticeSentence(step: "Practice 3", value: "beth parks her bike by"),
                    PracticeSentence(step: "Practice 4", value: "beth parks her bike by the shop.")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "keep a"),
                    PracticeSentence(step: "Practice 2", value: "keep a backup"),
                    PracticeSentence(step: "Practice 3", value: "keep a backup plan"),
                    PracticeSentence(step: "Practice 4", value: "keep a backup plan handy, bob.")
                ]
            ]
        case .mnrvu:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "marvin"),
                    PracticeSentence(step: "Practice 2", value: "marvin runs"),
                    PracticeSentence(step: "Practice 3", value: "marvin runs to the"),
                    PracticeSentence(step: "Practice 4", value: "marvin runs to the nearby van.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "a murmur"),
                    PracticeSentence(step: "Practice 2", value: "a murmur ran"),
                    PracticeSentence(step: "Practice 3", value: "a murmur ran through"),
                    PracticeSentence(step: "Practice 4", value: "a murmur ran through the room.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "the man"),
                    PracticeSentence(step: "Practice 2", value: "the man never"),
                    PracticeSentence(step: "Practice 3", value: "the man never returned"),
                    PracticeSentence(step: "Practice 4", value: "the man never returned home.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "turn"),
                    PracticeSentence(step: "Practice 2", value: "turn around"),
                    PracticeSentence(step: "Practice 3", value: "turn around and move,"),
                    PracticeSentence(step: "Practice 4", value: "turn around and move, marvin.")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "run up"),
                    PracticeSentence(step: "Practice 2", value: "run up the"),
                    PracticeSentence(step: "Practice 3", value: "run up the mountain,"),
                    PracticeSentence(step: "Practice 4", value: "run up the mountain, nervously.")
                ]
            ]
        case .ywxz:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "why waxy"),
                    PracticeSentence(step: "Practice 2", value: "why waxy boxes"),
                    PracticeSentence(step: "Practice 3", value: "why waxy boxes glow,"),
                    PracticeSentence(step: "Practice 4", value: "why waxy boxes glow, i ask.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "max wove"),
                    PracticeSentence(step: "Practice 2", value: "max wove a"),
                    PracticeSentence(step: "Practice 3", value: "max wove a cozy"),
                    PracticeSentence(step: "Practice 4", value: "max wove a cozy yellow yarn.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "a wacky"),
                    PracticeSentence(step: "Practice 2", value: "a wacky fox"),
                    PracticeSentence(step: "Practice 3", value: "a wacky fox jumps by"),
                    PracticeSentence(step: "Practice 4", value: "a wacky fox jumps by the zoo.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "zyra"),
                    PracticeSentence(step: "Practice 2", value: "zyra and"),
                    PracticeSentence(step: "Practice 3", value: "zyra and max play"),
                    PracticeSentence(step: "Practice 4", value: "zyra and max play with wax.")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "max will"),
                    PracticeSentence(step: "Practice 2", value: "max will enjoy"),
                    PracticeSentence(step: "Practice 3", value: "max will enjoy the"),
                    PracticeSentence(step: "Practice 4", value: "max will enjoy the lazy day.")
                ]
            ]
        case .efs:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "effervescent"),
                    PracticeSentence(step: "Practice 2", value: "effervescent fishes"),
                    PracticeSentence(step: "Practice 3", value: "effervescent fishes swim"),
                    PracticeSentence(step: "Practice 4", value: "effervescent fishes swim swiftly")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "soft"),
                    PracticeSentence(step: "Practice 2", value: "soft feathers"),
                    PracticeSentence(step: "Practice 3", value: "soft feathers ease"),
                    PracticeSentence(step: "Practice 4", value: "soft feathers ease gentle sleep")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "frosted"),
                    PracticeSentence(step: "Practice 2", value: "frosted desserts"),
                    PracticeSentence(step: "Practice 3", value: "frosted desserts make"),
                    PracticeSentence(step: "Practice 4", value: "frosted desserts make sweet endings")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "sleek"),
                    PracticeSentence(step: "Practice 2", value: "sleek foxes"),
                    PracticeSentence(step: "Practice 3", value: "sleek foxes swiftly"),
                    PracticeSentence(step: "Practice 4", value: "sleek foxes swiftly evade capture")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "effortless"),
                    PracticeSentence(step: "Practice 2", value: "effortless surfing"),
                    PracticeSentence(step: "Practice 3", value: "effortless surfing feels"),
                    PracticeSentence(step: "Practice 4", value: "effortless surfing feels so smooth")
                ]
            ]
        }
    }
}

enum UpperCaseLetterType: CaseIterable {
    case cgoq
    case ijltu
    case edfhk
    case bprs
    case axyz
    case mnvw
    
    var description: [String] {
        switch (self) {
        
        case .cgoq:
            return ["C", "G", "O", "Q"]
        case .ijltu:
            return ["I", "J", "L", "T", "U"]
        case .edfhk:
            return ["E", "D", "F", "H", "K"]
        case .bprs:
            return ["B", "P", "R", "S"]
        case .axyz:
            return ["A", "X", "Y", "Z"]
        case .mnvw:
            return ["M", "N", "V", "W"]
        }
    }
    
    var sentences: [[PracticeSentence]] {
        switch (self) {
            
        case .cgoq:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "QUICK"),
                    PracticeSentence(step: "Practice 2", value: "QUICK DOG"),
                    PracticeSentence(step: "Practice 3", value: "QUICK DOG CHASES"),
                    PracticeSentence(step: "Practice 4", value: "QUICK DOG CHASES CAT")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "QUIET"),
                    PracticeSentence(step: "Practice 2", value: "QUIET COW"),
                    PracticeSentence(step: "Practice 3", value: "QUIET COW GOES"),
                    PracticeSentence(step: "Practice 4", value: "QUIET COW GOES HOME")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "COZY"),
                    PracticeSentence(step: "Practice 2", value: "COZY LOG"),
                    PracticeSentence(step: "Practice 3", value: "COZY LOG CAUGHT"),
                    PracticeSentence(step: "Practice 4", value: "COZY LOG CAUGHT FIRE")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "GYM"),
                    PracticeSentence(step: "Practice 2", value: "GYM COACH"),
                    PracticeSentence(step: "Practice 3", value: "GYM COACH QUIT"),
                    PracticeSentence(step: "Practice 4", value: "GYM COACH QUIT EARLY")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "QUIRKY"),
                    PracticeSentence(step: "Practice 2", value: "QUIRKY CAT"),
                    PracticeSentence(step: "Practice 3", value: "QUIRKY CAT CLIMBS"),
                    PracticeSentence(step: "Practice 4", value: "QUIRKY CAT CLIMBS UP")
                ]
            ]
        case .ijltu:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "JULIA"),
                    PracticeSentence(step: "Practice 2", value: "JULIA JUST"),
                    PracticeSentence(step: "Practice 3", value: "JULIA JUST LIT A"),
                    PracticeSentence(step: "Practice 4", value: "JULIA JUST LIT A TULIP")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "LITTLE"),
                    PracticeSentence(step: "Practice 2", value: "LITTLE JILL"),
                    PracticeSentence(step: "Practice 3", value: "LITTLE JILL JUMPS"),
                    PracticeSentence(step: "Practice 4", value: "LITTLE JILL JUMPS A LOT")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "JUICY"),
                    PracticeSentence(step: "Practice 2", value: "JUICY FRUIT,"),
                    PracticeSentence(step: "Practice 3", value: "JUICY FRUIT, JIM"),
                    PracticeSentence(step: "Practice 4", value: "JUICY FRUIT, JIM MUST EAT")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "JUST"),
                    PracticeSentence(step: "Practice 2", value: "JUST CHILLIN'"),
                    PracticeSentence(step: "Practice 3", value: "JUST CHILLIN' TILL"),
                    PracticeSentence(step: "Practice 4", value: "JUST CHILLIN' TILL I JUMP")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "JUL PUT"),
                    PracticeSentence(step: "Practice 2", value: "JUL PUT A JET"),
                    PracticeSentence(step: "Practice 3", value: "JUL PUT A JET IN MY"),
                    PracticeSentence(step: "Practice 4", value: "JUL PUT A JET IN MY TUB")
                ]
            ]
        case .edfhk:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "ED'S DESK"),
                    PracticeSentence(step: "Practice 2", value: "ED'S DESK HAD"),
                    PracticeSentence(step: "Practice 3", value: "ED'S DESK HAD FUNKY"),
                    PracticeSentence(step: "Practice 4", value: "ED'S DESK HAD FUNKY HOOKS")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "THE CHEF"),
                    PracticeSentence(step: "Practice 2", value: "THE CHEF FRIED"),
                    PracticeSentence(step: "Practice 3", value: "THE CHEF FRIED OKRA"),
                    PracticeSentence(step: "Practice 4", value: "THE CHEF FRIED OKRA HEADS")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "EACH KID"),
                    PracticeSentence(step: "Practice 2", value: "EACH KID HAD"),
                    PracticeSentence(step: "Practice 3", value: "EACH KID HAD FUN"),
                    PracticeSentence(step: "Practice 4", value: "EACH KID HAD FUN DIGGING")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "HOLD"),
                    PracticeSentence(step: "Practice 2", value: "HOLD THE"),
                    PracticeSentence(step: "Practice 3", value: "HOLD THE DESK"),
                    PracticeSentence(step: "Practice 4", value: "HOLD THE DESK FIRMLY, ED")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "THE HEDGEHOG"),
                    PracticeSentence(step: "Practice 2", value: "THE HEDGEHOG DRANK"),
                    PracticeSentence(step: "Practice 3", value: "THE HEDGEHOG DRANK COFFEE"),
                    PracticeSentence(step: "Practice 4", value: "THE HEDGEHOG DRANK COFFEE")
                ]
            ]
        case .bprs:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "PARK THE"),
                    PracticeSentence(step: "Practice 2", value: "PARK THE BUS"),
                    PracticeSentence(step: "Practice 3", value: "PARK THE BUS BY"),
                    PracticeSentence(step: "Practice 4", value: "PARK THE BUS BY THE BARN")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "GRAB A"),
                    PracticeSentence(step: "Practice 2", value: "GRAB A SPARE"),
                    PracticeSentence(step: "Practice 3", value: "GRAB A SPARE RIB,"),
                    PracticeSentence(step: "Practice 4", value: "GRAB A SPARE RIB, PLEASE")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "BART"),
                    PracticeSentence(step: "Practice 2", value: "BART BRINGS"),
                    PracticeSentence(step: "Practice 3", value: "BART BRINGS SUPERB"),
                    PracticeSentence(step: "Practice 4", value: "BART BRINGS SUPERB PIES")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "PARIS"),
                    PracticeSentence(step: "Practice 2", value: "PARIS SPARKS"),
                    PracticeSentence(step: "Practice 3", value: "PARIS SPARKS BRIGHT"),
                    PracticeSentence(step: "Practice 4", value: "PARIS SPARKS BRIGHT HOPE")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "BRISK"),
                    PracticeSentence(step: "Practice 2", value: "BRISK TRIP"),
                    PracticeSentence(step: "Practice 3", value: "BRISK TRIP SPURS"),
                    PracticeSentence(step: "Practice 4", value: "BRISK TRIP SPURS PLANS")
                ]
            ]
        case .axyz:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "ALEX"),
                    PracticeSentence(step: "Practice 2", value: "ALEX IS"),
                    PracticeSentence(step: "Practice 3", value: "ALEX IS MY"),
                    PracticeSentence(step: "Practice 4", value: "ALEX IS MY LAZY COUSIN.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "ZANY"),
                    PracticeSentence(step: "Practice 2", value: "ZANY XYLOPHONES"),
                    PracticeSentence(step: "Practice 3", value: "ZANY XYLOPHONES YIELD"),
                    PracticeSentence(step: "Practice 4", value: "ZANY XYLOPHONES YIELD JOY.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "YACHTS"),
                    PracticeSentence(step: "Practice 2", value: "YACHTS ANCHOR"),
                    PracticeSentence(step: "Practice 3", value: "YACHTS ANCHOR IN"),
                    PracticeSentence(step: "Practice 4", value: "YACHTS ANCHOR IN THE BAY.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "ZOOMING"),
                    PracticeSentence(step: "Practice 2", value: "ZOOMING AIRPLANES"),
                    PracticeSentence(step: "Practice 3", value: "ZOOMING AIRPLANES FLY"),
                    PracticeSentence(step: "Practice 4", value: "ZOOMING AIRPLANES FLY BY.")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "THE AX"),
                    PracticeSentence(step: "Practice 2", value: "THE AX IS"),
                    PracticeSentence(step: "Practice 3", value: "THE AX IS HEAVY"),
                    PracticeSentence(step: "Practice 4", value: "THE AX IS HEAVY DUTY.")
                ]
            ]
        case .mnvw:
            return [
                [
                    /// Sentence 1
                    PracticeSentence(step: "Practice 1", value: "NEW"),
                    PracticeSentence(step: "Practice 2", value: "NEW VAN"),
                    PracticeSentence(step: "Practice 3", value: "NEW VAN WAITS"),
                    PracticeSentence(step: "Practice 4", value: "NEW VAN WAITS NEARBY.")
                ],
                [
                    /// Sentence 2
                    PracticeSentence(step: "Practice 1", value: "MANY"),
                    PracticeSentence(step: "Practice 2", value: "MANY MICE"),
                    PracticeSentence(step: "Practice 3", value: "MANY MICE NEVER"),
                    PracticeSentence(step: "Practice 4", value: "MANY MICE NEVER WIN.")
                ],
                [
                    /// Sentence 3
                    PracticeSentence(step: "Practice 1", value: "WOMEN"),
                    PracticeSentence(step: "Practice 2", value: "WOMEN VALUE"),
                    PracticeSentence(step: "Practice 3", value: "WOMEN VALUE NEW"),
                    PracticeSentence(step: "Practice 4", value: "WOMEN VALUE NEW IDEAS.")
                ],
                [
                    /// Sentence 4
                    PracticeSentence(step: "Practice 1", value: "NEVER"),
                    PracticeSentence(step: "Practice 2", value: "NEVER MIND,"),
                    PracticeSentence(step: "Practice 3", value: "NEVER MIND, WE"),
                    PracticeSentence(step: "Practice 4", value: "NEVER MIND, WE WON!")
                ],
                [
                    /// Sentence 5
                    PracticeSentence(step: "Practice 1", value: "VIVID"),
                    PracticeSentence(step: "Practice 2", value: "VIVID WINTER"),
                    PracticeSentence(step: "Practice 3", value: "VIVID WINTER MORNING."),
                    PracticeSentence(step: "Practice 4", value: "VIVID WINTER MORNING.")
                ]
            ]
        }
    }
}

enum LetterType {
    case lowerCase
    case upperCase
}

struct GroupLetterItem: Identifiable {
    var id: UUID = UUID()
    var type: LetterType
    var letters: [String]
    var sentences: [[PracticeSentence]]
    
    static var lowerCaseItems: [GroupLetterItem] {
        return LowerCaseLetterType.allCases.map { type in
            GroupLetterItem(
                type: .lowerCase, letters: type.description, sentences: type.sentences
            )
        }
    }
    
    static var upperCaseItems: [GroupLetterItem] {
        return UpperCaseLetterType.allCases.map { type in
            GroupLetterItem(
                type: .upperCase, letters: type.description, sentences: type.sentences
            )
        }
    }
}
