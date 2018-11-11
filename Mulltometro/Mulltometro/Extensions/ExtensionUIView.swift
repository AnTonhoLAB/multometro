//
//  ExtensionUIView.swift
//  Mulltometro
//
//  Created by George Gomes on 19/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundedCornerColor(borderColor: UIColor = .clear, borderWidth: CGFloat = 0, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
    
    func roundedSideBorder() {
        roundedCornerColor(radius: frame.size.height/2.0)
    }
    
    func circleView(_ border: CGFloat = 0) {
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = border
    }
}
