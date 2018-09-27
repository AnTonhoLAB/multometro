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
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        
        ref = db.collection("user").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        



        function.httpsCallable("addGeorge").call { res, err in
            print(res)
            print(err)
        }

        
    }
    
}

