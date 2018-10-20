//
//  Tax.swift
//  Mulltometro
//
//  Created by George Gomes on 02/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

class Fee: Codable {

    var name: String!
    var valuePerType: Int!
    var valueType: String!
    var simbleType: String!
    
    init(name: String, valuePerType: Int, valueType: String!, simbleType: String) {
        self.name  = name
        self.valuePerType = valuePerType
        self.simbleType = simbleType
    }
    
    init() {}
    
    func toData() -> [String: Any] {
        var data = [String: Any]()
        
        data["name"] = name
        data["valuePerType"] = String(valuePerType)
        data["valueType"] = valueType
        data["simbleType"] = simbleType
        
        return data
    }
    
}
