//
//  ViewController.swift
//  Mulltometro
//
//  Created by George Gomes on 25/09/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    lazy var function = Functions.functions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func gotoLa(_ sender: Any) {
       
        let datas = ["name": "George", "idade": "23"]

        function.httpsCallable("addAUser").call(["name": "Giorgino", "idade": "23"]) { res, err in
            print("res ",res?.data ?? "nao tem res")
            print("err", err ?? "nao tem err")
        }
        
        function.httpsCallable("addAUser").call(datas) { res, err in
            print("res ",res?.data ?? "nao tem res")
            print("err", err ?? "nao tem err")
        }
    }
    
}

