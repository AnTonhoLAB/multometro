//
//  ProfileViewController.swift
//  Multometro
//
//  Created by George Gomes on 01/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogout(_ sender: Any) {
        AuthManager.logout { [weak self] response in
            guard let self = self else { return }

            switch response {
            case .success(_):
                CDManager.logout(completion: { response in
                    switch response {
                        
                    case .success(_):
                        guard let window = UIApplication.shared.keyWindow else { return }

                        let retisterUserStoryboard: UIStoryboard = R.storyboard.login()
                        let viewController = retisterUserStoryboard.instantiateViewController(withIdentifier : R.string.strings.loginIdentifier())
                        
                        UIView.transition(with: window, duration: 0.4, options: .transitionCrossDissolve, animations: {
                            window.rootViewController = viewController
                        }, completion: nil)
                    case .failure(let error):
                        self.alertSimpleMessage(message: error.localizedDescription)
                    }
                })
                print("remove coreData")
                print("Go To Login")
            case .failure(let error):
                self.alertSimpleMessage(message: error.localizedDescription)
            }
        }
    }
}
