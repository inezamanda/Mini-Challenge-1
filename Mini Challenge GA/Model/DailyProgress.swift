//
//  DailyProgress.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

struct DailyProgress {
    var date: String
    var inProgress: Int
    var done: Int
    var percentage: Int

    init(date: String, inProgress: Int, done: Int, percentage: Int){
        self.date = date
        self.inProgress = inProgress
        self.done = done
        self.percentage = percentage
    }
    
}
