//
//  ExtensionViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 17/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

extension UIViewController {
    func alertSimpleMessage(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: R.string.localizable.ok(), style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

