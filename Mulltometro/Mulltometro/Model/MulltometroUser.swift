//
//  User.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation
import CoreData

class MulltometroUser: Codable {
   
    var uid: String?
    var name: String!
    var email: String!
    var photoURL: String?
    var rooms: [Room]?
    var firstTime: Bool?
    
    init(name: String, email: String, rooms: [Room]) {
        self.name = name
        self.email = email
        self.rooms = rooms
    }
    
    init(uid: String, name: String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
        self.firstTime = false
    }
    
    init() {
        
    }
    
    func toCDObject() -> User {
        let user: User = CDManager.Object()
        user.email = self.email
        user.uid = self.uid
        user.firstTime = false
        user.name = self.name
        
        return user
    }
}
