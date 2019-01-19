//
//  ExtensionCodable.swift
//  Multometro
//
//  Created by George Gomes on 20/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import Foundation

extension Encodable {
    subscript(key: String) -> Any? {
        return dictionary[key]
    }
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
