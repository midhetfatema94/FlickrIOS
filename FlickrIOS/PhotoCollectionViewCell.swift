//
//  PhotoCollectionViewCell.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoView: UIImageView!
    
    func configure(data: Entry) {
        if let imageUrl = URL(string: data.imageUrlString) {
            photoView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
}
