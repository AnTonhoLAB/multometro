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

class RoomRequester {
    
    private static var function = Functions.functions()
    
    private init() {}
    
    static func addRoom(with room: [String: Any]) {

        function.httpsCallable("addRoom").call(room) { (res, err) in
          print(res ?? "nao tem res")
          print(err ?? "nao tem err")
        }
    }
   
  
    
//    function.httpsCallable("addAUser").call(["name": "Giorgino", "idade": "23"]) { res, err in}
}
