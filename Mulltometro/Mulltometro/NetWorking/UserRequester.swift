//
//  UserRequester.swift
//  Mulltometro
//
//  Created by George Gomes on 10/11/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import Firebase
import Rswift

class UserRequester {
    private static var function = Functions.functions()
    
    class func configUser(completion: @escaping (Bool) -> Void) {
        let uid = ["uid": AuthManager.getCurrentUserId()]
        
         function.httpsCallable("setupUser").call(uid) { _, err in
            if err != nil {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}
