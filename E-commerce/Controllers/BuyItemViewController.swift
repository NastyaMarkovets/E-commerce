//
//  BuyItemViewController.swift
//  E-commerce
//
//  Created by Anastasia Markovets on 05.12.2018.
//  Copyright © 2018 Lonely Tree Std. All rights reserved.
//

import UIKit
import Firebase 

class BuyItemViewController: UIViewController {
    
    @IBOutlet weak var nameItemLabel: UILabel!
    @IBOutlet weak var nameCustomerTextField: UITextField!
    @IBOutlet weak var mobileCustomerTextField: UITextField!
    @IBOutlet weak var emailCustomerTextField: UITextField!
    @IBOutlet weak var buyView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    
    var itemInformation: Item?
    let fetchModel = FetchDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let name = itemInformation?.name {
            self.nameItemLabel.text = name
        }

        self.backButton.layer.borderWidth = 1
        self.backButton.layer.borderColor = UIColor(red: 11.0/255.0, green: 86.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor
        
        self.buyView.layer.cornerRadius = 9
        
        self.nameCustomerTextField.keyboardAppearance = .dark
        self.mobileCustomerTextField.keyboardAppearance = .dark
        self.emailCustomerTextField.keyboardAppearance = .dark
        
        let bottomSwipe = UISwipeGestureRecognizer(target: self, action: #selector(hideKeyboard))
        bottomSwipe.direction = UISwipeGestureRecognizerDirection.down
        self.view.addGestureRecognizer(bottomSwipe)
        
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    

    @IBAction func buyItem(_ sender: Any) {
        if let itemInfo = itemInformation, let nameCustomerText = nameCustomerTextField.text, let mobileCustomerText = mobileCustomerTextField.text, let emailCustomerText = emailCustomerTextField.text {
            
            var dict = [String : Any]()
            
            if let name = itemInfo.name, let price = itemInfo.price, let desc = itemInfo.itemDescription, let url = itemInfo.imageURLString {
                dict = ["name": name, "price": price, "desc": desc, "imageURL": url] as [String : Any]
            }
            let values = ["name": nameCustomerText, "mobile": mobileCustomerText, "email": emailCustomerText, "item": dict] as [String : Any]
            
            self.fetchModel.sendPurchase(values: values) {
                let successMessage = UIAlertController(title: "Your order", message: "Saved order successfully.", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self.dismiss(animated: true, completion: nil)
                })
                successMessage.addAction(cancel)
                self.present(successMessage, animated: true, completion: nil)
            }
        }
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
