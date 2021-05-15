//
//  Entry.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import Foundation

class Entry: Collection {
    
    var imageUrlString: String
    var authorName: String?
    var imageDate: String?
    var imageTitle: String
    
    init(details: [String: Any]) {
        
        imageUrlString = details["image"] as? String ?? ""
        
        imageTitle = details["title"] as? String ?? ""
        
        if let authorDetails = details["author"] as? [String: Any] {
            authorName = authorDetails["name"] as? String ?? ""
        }
        
        imageDate = DateHelper.shared.formatterString(from: details["published"] as? String ?? "")
        
        let id = details["id"] as? String ?? ""
        super.init(id: id)
    }
}

class DateHelper {
    static let shared = DateHelper()
    
    let dateFormatter = DateFormatter()
    
    func formatterString(from date: String) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let myDate = dateFormatter.date(from: date) else { return nil }
        
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter.string(from: myDate)
    }
}
