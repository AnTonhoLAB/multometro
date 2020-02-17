//
//  ViewController.swift
//  Multometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Rswift

class MainTabBarController: UITabBarController {


    init(with viewControllers: [UIViewController]) {
        super.init(nibName: nil, bundle: nil)
        self.viewControllers = viewControllers
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }

    func setup() {
        
        guard let viewControllers = viewControllers else { return }
        
        for (index, viewController) in (viewControllers.enumerated()) {
            switch index {
            case 0:
                viewController.tabBarItem.tag = 0//Controller.supplier.rawValue
                viewController.tabBarItem.image = #imageLiteral(resourceName: "group")
            case 1:
                viewController.tabBarItem.tag = 1//Controller.supplier.rawValue
                viewController.tabBarItem.image = #imageLiteral(resourceName: "group")
            case 2:
                viewController.tabBarItem.tag = 2//Controller.supplier.rawValue
                viewController.tabBarItem.image = #imageLiteral(resourceName: "group")
            default:  break
            }
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        }
        self.tabBarController?.tabBar.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
    
    }    

}

