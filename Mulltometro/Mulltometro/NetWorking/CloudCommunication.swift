//
//  CloudCommunication.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Firebase
import Rswift

class CloudCommunication {
    
    private static var function = Functions.functions()
    
    private init() {}
    
    static func createRoom(with name: String) {
        
        let adminUid = AuthManager.getCurrentUserId()
        let data = ["name": name, "adminUid": adminUid]
        
//        function.httpsCallable("addRoom").call(data) { (res, err) in
//            print(err)
//            print(res)
//        }
    
        let dd = ["name": "Georgito",
                  "idade": "33",
                  "uid": adminUid]
        
        function.httpsCallable("callHome").call(dd) { (res, eer) in
            print(eer ?? "Sem erro")
            print(res.debugDescription)
        }
    
    }
   
  
    
//    function.httpsCallable("addAUser").call(["name": "Giorgino", "idade": "23"]) { res, err in}
}
