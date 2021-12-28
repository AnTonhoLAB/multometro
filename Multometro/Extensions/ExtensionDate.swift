//
//  ExtensionDate.swift
//  Multometro
//
//  Created by George Gomes on 18/01/19.
//  Copyright © 2019 CrowCode. All rights reserved.
//

import Foundation

extension Date {
    var localizedString: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.setLocalizedDateFormatFromTemplate("ddMMyyyy")
        let string = formatter.string(from: self)
        return string
    }
}
