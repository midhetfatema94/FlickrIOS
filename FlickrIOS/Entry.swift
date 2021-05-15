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
        
        /*
         [
         "author":
         ["flickr:buddyicon": "https://farm4.staticflickr.com/3769/buddyicons/46795046@N02.jpg?1392804477#46795046@N02", "": "zikade", "uri": "https://www.flickr.com/people/wolfgangthielke/", "flickr:nsid": "46795046@N02"], "": "2021-05-15_01-57-24", "flickr:date_taken": "2021-05-03T16:07:22-08:00", "published": "2021-05-15T11:57:27Z"]
         */
        
        imageUrlString = details["image"] as? String ?? ""
        
        imageTitle = details["title"] as? String ?? ""
        
        if let authorDetails = details["author"] as? [String: Any] {
            authorName = authorDetails["name"] as? String ?? ""
        }
        
        let id = details["id"] as? String ?? ""
        super.init(id: id)
    }
}
