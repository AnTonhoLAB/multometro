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
    var rooms: [String]?
    var taxes: [Fee]?
    
    init(name: String, email: String, rooms: [String], taxes: [Fee]) {
        self.name = name
        self.email = email
        self.rooms = rooms
        self.taxes = taxes
    }
    
}
