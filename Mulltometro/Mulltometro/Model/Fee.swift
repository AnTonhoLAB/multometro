//
//  Tax.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Fee: Codable {

    var id: String!
    var name: String!
    var valuePerType: Int!
    var valueType: String!
    var simbleType: String!
    
    init(id: String, name: String, valuePerType: Int, valueType: String!, simbleType: String) {
        self.id = id
        self.name  = name
        self.valuePerType = valuePerType
        self.simbleType = simbleType
    }
    
}
