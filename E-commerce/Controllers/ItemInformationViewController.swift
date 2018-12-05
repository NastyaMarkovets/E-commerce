//
//  ItemInformationViewController.swift
//  E-commerce
//
//  Created by Anastasia Markovets on 05.12.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit

class ItemInformationViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemDescTextView: UITextView!
    
    var information: Item?
    var imageItem: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let info = information {
            if let name = info.name {
                self.itemNameLabel.text = name
            }
            if let price = info.price {
                self.itemPriceLabel.text = "$\(price)"
            }
            if let desc = info.itemDescription {
                self.itemDescTextView.text = desc
            }
            if let img = imageItem {
                self.itemImageView.image = img
            }
        }
        
    }
    
   
    // MARK: - Parse data
    @IBAction func checkoutItem(_ sender: Any) {
        self.performSegue(withIdentifier: "buySegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let itemInfo = information {
            if let destinationVC = segue.destination as? BuyItemViewController {
                destinationVC.itemInformation = itemInfo
            }
        }
        
    }
}
