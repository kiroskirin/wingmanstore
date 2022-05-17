//
//  WMExtensionUIViewController.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/18/22.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ title: String?, message: String?) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertView.addAction(okAction)
        
        self.present(alertView, animated: true)
    }
}
