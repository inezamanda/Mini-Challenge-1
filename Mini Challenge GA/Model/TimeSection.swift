//
//  TimeSection.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

class TimeSection {
    var name: String
    var data: [DailyProgress]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> DailyProgress {
        return data[index]
    }
    
    init(name: String, data: [DailyProgress]){
        self.name = name
        self.data = data
    }
}
