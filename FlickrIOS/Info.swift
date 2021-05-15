//
//  Info.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import Foundation

class Info: Collection {
    
    var authorName: String?
    var imageDate: String?
    var imageTitle: String
    
    init(details: Entry) {
        
        imageTitle = details.imageTitle
        authorName = details.authorName
        imageDate = details.imageDate
        
        let id = details.id
        super.init(id: id)
    }
}
