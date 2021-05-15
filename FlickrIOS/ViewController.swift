//
//  ViewController.swift
//  FlickrIOS
//
//  Created by Midhet Sulemani on 5/15/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedView: UICollectionView!
    
    var vm = EntryList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.fetchFeed(completionHandler: {[weak self] _ in
            DispatchQueue.main.async {
                self?.feedView.reloadData()
            }
        })
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vm.allCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let entry = vm.allCells[indexPath.row] as? Entry,
           let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as? PhotoCollectionViewCell {
            photoCell.configure(data: entry)
            return photoCell
        } else if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as? InfoCollectionViewCell {
            return infoCell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let photoCell = collectionView.cellForItem(at: indexPath) {
            photoCell.layer.borderColor = UIColor.blue.cgColor
            photoCell.layer.borderWidth = 2.0
            vm.addInfo(index: indexPath.row, offset: 0, completionHandler: {
                self.feedView.reloadData()
            })
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 175)
    }
}
