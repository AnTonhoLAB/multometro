//
//  ExtensionUIColor.swift
//  Mulltometro
//
//  Created by George Gomes on 20/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var redSystem: UIColor {
        return makeColorWith(red: 202, green: 53, blue: 38, alpha: 255)
    }
    
    static var blackSystem: UIColor {
        return makeColorWith(red: 255, green: 255, blue: 255, alpha: 255)
    }
    
    static var grey: UIColor {
        return  makeColorWith(red: 202, green: 53, blue: 38, alpha: 255)
    }
    
    static func makeColorWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(displayP3Red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha / 255)
    }
}
