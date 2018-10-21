//
//  User.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class MulltometroUser: Codable {
   
    var id: String?
    var name: String!
    var email: String!
    var type: String?
    var rooms: [String]?
    var taxes: [Fee]?
    
    init(name: String, email: String, type: String, rooms: [String], taxes: [Fee]) {
        self.name = name
        self.email = email
        self.type = type
        self.rooms = rooms
        self.taxes = taxes
    }
    
}
