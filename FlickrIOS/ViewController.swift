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
    var selectedId = ""
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
            if selectedId == vm.allCells[indexPath.row].id {
                photoCell.layer.borderColor = UIColor.blue.cgColor
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
        selectedId = vm.allCells[indexPath.row].id
        vm.addInfo(index: indexPath.row, offset: getOffset(index: indexPath.row), completionHandler: {[weak self] in
            UIView.animate(withDuration: 0.5) {
                let indexSet = IndexSet(integersIn: 0...0)
                self?.feedView.reloadSections(indexSet)
            }
        })
    }
    
    func getOffset(index: Int) -> Int {
        let rowItems = Int(feedView.bounds.width/175)
        let correctIndex = infoIndex < index ? index - 1 : index
        let rowIndex = correctIndex/rowItems
        return (rowItems * rowIndex) + 1
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if vm.allCells[indexPath.row] is Entry {
            return CGSize(width: 175, height: 175)
        }
        return CGSize(width: 300, height: 175)
    }
}
