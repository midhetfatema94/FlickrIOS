//
//  InfoCollectionViewCell.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(data: Info) {
        titleLabel.text = data.imageTitle
        authorLabel.text = "Clicked by: \(data.authorName ?? "")"
        dateLabel.text = data.imageDate
    }
}
