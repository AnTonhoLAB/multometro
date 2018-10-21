//
//  Room.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Room: Codable {
    
    var id: String?
    var adminId: String!
    var nameRoom: String!
    var fees: [Fee]?
    var users: [String]?
    var dueDate: Int!
    
    init() {
        
    }
    
    init(name: String, dueDate: Int) {
        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.dueDate = dueDate
    }
    
    init(likeUserTo name: String, fees: [Fee]?, dueDate: Int) {
        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
        self.users = [AuthManager.getCurrentUserId()]
    }
    
    init(name: String, fees: [Fee]?, dueDate: Int) {
        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
    }
    
    init(name: String, fees: [Fee]?, adminUid: String, users: [String]?, dueDate:Int ) {
        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.dueDate = dueDate
        self.fees = fees
        self.adminId = adminUid
        self.users = users
    }
}
