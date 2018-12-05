//
//  ItemCollectionViewCell.swift
//  E-commerce
//
//  Created by Anastasia Markovets on 04.12.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
