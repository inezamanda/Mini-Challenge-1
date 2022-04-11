//
//  FinalProjectCompletion.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

struct FinalProjectCompletion: DataProtocol{
    var emoji: String
    var category: String
    var notStarted: Int
    var inProgress: Int
    var done: Int
    var percentage: Int

    init(category: String, notStarted: Int, inProgress: Int, done: Int, percentage: Int, emoji: String){
        self.category = category
        self.notStarted = notStarted
        self.inProgress = inProgress
        self.done = done
        self.percentage = percentage
        self.emoji = emoji
    }
}
