//
//  ViewController.swift
//  E-commerce
//
//  Created by Anastasia Markovets on 04.12.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

class ItemsCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionItems: UICollectionView!
    
    var itemSize: CGFloat!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let fetchModel = FetchDataModel()
    var items = [Item]() {
        didSet {
            self.collectionItems.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionItems.delegate = self
        self.collectionItems.dataSource = self
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionItems.register(nib, forCellWithReuseIdentifier: "itemCell")
        
        self.sizeCollectionViewCell()
        
        self.fetchModel.fetchItems { (newItem) in
            self.items.append(newItem)
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout protocol
    func sizeCollectionViewCell() {
        let screenSize = UIScreen.main.bounds
        itemSize = screenSize.width / 2
        
        self.layout.itemSize = CGSize(width: itemSize, height: itemSize)
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 10
        self.collectionItems.collectionViewLayout = layout
    }
    
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: itemSize, height: itemSize)
        
    }

    // MARK: - UICollectionViewDataSource protocol
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath as IndexPath) as! ItemCollectionViewCell
        
        if let name = items[indexPath.row].name {
            cell.itemName.text = name
        }
        
        if let price = items[indexPath.row].price {
            cell.itemPrice.text = "$\(price)"
        }
        
        if let imageURL = items[indexPath.row].imageURLString {
            self.fetchModel.fetchImage(url: imageURL) { (dataImage) in
                cell.itemImage.image = UIImage(data: dataImage, scale: 1)
            }
        }
        return cell
    }
    
    // MARK: - Parse data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "itemSegue", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = sender as? IndexPath else { return }
        
        let itemData = items[indexPath.row]
        let cell = self.collectionItems.cellForItem(at: indexPath) as! ItemCollectionViewCell
        
        if let destinationVC = segue.destination as? ItemInformationViewController {
            destinationVC.information = itemData
            if let image = cell.itemImage.image {
                destinationVC.imageItem = image
            }
        }
    }

}

