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
    var adminUid: String!
    var name: String!
    var fees: [Fee]?
    var users: [String]?
    var dueDate: Int!
    
    init(name: String, dueDate: Int) {
        self.adminUid = AuthManager.getCurrentUserId()
        self.name = name
        self.dueDate = dueDate
    }
    
    init(likeUserTo name: String, fees: [Fee]?, dueDate: Int) {
        self.adminUid = AuthManager.getCurrentUserId()
        self.name = name
        self.fees = fees
        self.dueDate = dueDate
        self.users = [AuthManager.getCurrentUserId()]
    }
    
    init(name: String, fees: [Fee]?, dueDate: Int) {
        self.adminUid = AuthManager.getCurrentUserId()
        self.name = name
        self.fees = fees
        self.dueDate = dueDate
    }
    
    init(name: String, fees: [Fee]?, adminUid: String, users: [String]?, dueDate:Int ) {
        self.adminUid = AuthManager.getCurrentUserId()
        self.name = name
        self.dueDate = dueDate
        self.fees = fees
        self.adminUid = adminUid
        self.users = users
    }
    
    func toData() -> [String: Any] {
        var data = [String: Any]()
        
        if let id = id {
            data["id"] = id
        }
        
        data["adminId"] = adminUid
        data["name"] = name
        data["dueDate"] = String(dueDate)
        
        if let fees = fees {
            let feesData = fees.map{$0.toData()}
            data["feeTypes"] = feesData
        }
        
        if let users = users {
            data["users"] = users
        }
        
        return data
    }
    
}
