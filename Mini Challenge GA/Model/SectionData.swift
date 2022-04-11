//
//  SectionData.swift
//  Mini Challenge GA
//
//  Created by Inez Amanda on 09/04/22.
//

import UIKit

class SectionData {
    var name: String
    var data: [DataProtocol]
    
    var numberOfItems: Int {
        return data.count
    }
    
    subscript(index: Int) -> DataProtocol {
        return data[index]
    }
    
    init(name: String, data: [DataProtocol]){
        self.name = name
        self.data = data
    }
}
