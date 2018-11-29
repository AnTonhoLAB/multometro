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
    var admin: MulltometroUser?
    var nameRoom: String!
    var fees: [Fee]?
    var users: [MulltometroUser]?
    var dueDate: Int!
    var created: Date!
    
    init() {
 
    }
    
    init(name: String, dueDate: Int, created: Date? = Date()) {
//        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.dueDate = dueDate
        self.created = created
    }
    
    init(likeUserTo name: String, fees: [Fee]?, dueDate: Int, created: Date? = Date()) {
//        self.adminId = AuthManager.getCurrentUserId()
//        self.admin = AuthManager.selfUser
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
//        self.users = [AuthManager.getCurrentUserId()]
        self.created = created
    }
    
    init(name: String, fees: [Fee]?, dueDate: Int, created: Date? = Date()) {
//        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.fees = fees
        self.dueDate = dueDate
        self.created = created
    }
    
    init(name: String, fees: [Fee]?, adminUid: String, users: [String]?, dueDate:Int, created: Date? = Date()) {
//        self.adminId = AuthManager.getCurrentUserId()
        self.nameRoom = name
        self.dueDate = dueDate
        self.fees = fees
//        self.adminId = adminUid
//        self.users = users
        self.created = created
    }
}

struct SimpleUser {
    var name: String
    var email: String
    var firstTime: Bool
    var uid: String
}
