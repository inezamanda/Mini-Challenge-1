//
//  Report.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

struct Report: DataProtocol {
    var emoji: String
    var time: String
    var durationTarget: String
    var words: String
    
    init(time: String, durationTarget: String, words: String, emoji: String){
        self.time = time
        self.durationTarget = durationTarget
        self.words = words
        self.emoji = emoji
    }
}
