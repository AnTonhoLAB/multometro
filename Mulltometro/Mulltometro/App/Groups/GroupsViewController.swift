//
//  GroupsViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 01/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapAddRoom(_ sender: Any) {
        performSegue(withIdentifier: R.segue.groupsViewController.toAddGroup, sender: nil)
    }
}
