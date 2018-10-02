//
//  User.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class User: Codable {
   
    var id: String!
    var name: String!
    var email: String!
    var type: String!
    var rooms: [String]!
    var taxes: [Tax]
    
}
