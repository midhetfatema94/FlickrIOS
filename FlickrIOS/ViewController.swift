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
    var selectedItem = Collection(id: "")
    var infoIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.fetchFeed(completionHandler: {[weak self] error in
            DispatchQueue.main.async {
                if error == nil {
                    self?.feedView.reloadData()
                }
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
            
            if selectedItem == vm.allCells[indexPath.row] {
                photoCell.layer.borderColor = UIColor.systemIndigo.cgColor
                photoCell.layer.borderWidth = 2.0
            } else {
                photoCell.layer.borderColor = UIColor.clear.cgColor
            }
            
            return photoCell
        } else if let infoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as? InfoCollectionViewCell, let info = vm.allCells[indexPath.row] as? Info {
            infoCell.configure(data: info)
            
            infoIndex = indexPath.row
            
            return infoCell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = vm.allCells[indexPath.row]
        vm.addInfo(index: indexPath.row, offset: getOffset(), completionHandler: {[weak self] in
            UIView.animate(withDuration: 0.5) {
                let indexSet = IndexSet(integersIn: 0...0)
                self?.feedView.reloadSections(indexSet)
            }
        })
    }
    
    func getOffset() -> Int {
        let cellDimension = (feedView.bounds.width/2) - 5
        let rowItems = Int(feedView.bounds.width/cellDimension)
        let filteredArray = vm.allCells.filter { $0 is Entry }
        let index = filteredArray.firstIndex(of: selectedItem) ?? -1
        let rowIndex = index/rowItems + 1
        return rowIndex * 2
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if vm.allCells[indexPath.row] is Entry {
            let cellDimension = (feedView.bounds.width/2) - 5
            return CGSize(width: cellDimension, height: cellDimension)
        }
        return CGSize(width: feedView.bounds.width, height: 130)
    }
}
