//
//  ViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func gotoLa(_ sender: Any) {
        performSegue(withIdentifier: "toLa", sender: nil)
    }
    
}

