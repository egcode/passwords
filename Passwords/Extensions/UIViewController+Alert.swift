//
//  UIViewController+Alert.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

public extension UIViewController {
        
    @objc func showAlert(title: String, message: String, completion: (()->())? = nil) {
        
        let okButton = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: okButton, style: .default, handler: { (alertAction) in
            if let c = completion {
                c()
            }
        })
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
