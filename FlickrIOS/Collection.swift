//
//  Collection.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import Foundation

class Collection: Equatable {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    static func == (lhs: Collection, rhs: Collection) -> Bool {
        return lhs.id == rhs.id
    }
}
