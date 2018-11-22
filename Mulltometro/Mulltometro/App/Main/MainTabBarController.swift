//
//  ViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserRequester.startSync()
        setup()
    }
    
    func setup() {
        
        guard let viewControllers = viewControllers else { return }
        
        for (index, viewController) in (viewControllers.enumerated()) {
            switch index {
            case 0:
                viewController.tabBarItem.tag = 0//Controller.supplier.rawValue
                viewController.tabBarItem.image = R.image.group()
            case 1:
                viewController.tabBarItem.tag = 0//Controller.supplier.rawValue
                viewController.tabBarItem.image = R.image.stats()
            case 2:
                viewController.tabBarItem.tag = 0//Controller.supplier.rawValue
                viewController.tabBarItem.image = R.image.profile()
            default:  break
            }
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }    

}

