//
//  FetchDataModel.swift
//  E-commerce
//
//  Created by Anastasia Markovets on 05/12/2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

class FetchDataModel: NSObject {

    
    
    func fetchItems(success: @escaping (Item) -> ()) {
        Database.database().reference().child("items").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let item = Item()
                
                guard let name = dictionary["name"] as? String else { return }
                guard let price = dictionary["price"] as? Double else { return }
                guard let desc = dictionary["desc"] as? String else { return }
                guard let imageURL = dictionary["imageURL"] as? String else { return }
                item.name = name
                item.price = price
                item.itemDescription = desc
                item.imageURLString = imageURL

                success(item)
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func fetchImage(url: String, success: @escaping (Data) -> ()) {
        Alamofire.request(url).response { (response) in
            if let dataImage = response.data {
                DispatchQueue.main.async {
                    success(dataImage)
                }
            }
        }
        
    }
    
    
    func sendPurchase(values: [String : Any], success: @escaping () -> ()) {
        Database.database().reference().child("orders").childByAutoId().updateChildValues(values) { (error, ref) in
            if error != nil {
                return
            }
            success()
            
        }
    }
}
