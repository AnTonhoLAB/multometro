//
//  AddFeeRegisterCell.swift
//  Mulltometro
//
//  Created by George Gomes on 19/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class AddFeeRegisterCelll: UITableViewCell {
    
    @IBOutlet weak var backGroundView: UIView!
    
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var constraintBot: NSLayoutConstraint!
    @IBOutlet weak var constraintLft: NSLayoutConstraint!
    @IBOutlet weak var constraintRgt: NSLayoutConstraint!
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbValuePerFee: UILabel!
    @IBOutlet weak var lbValueType: UILabel!
    @IBOutlet weak var lbSimble: UILabel!
    
    func animationSave(){
        self.constraintTop.constant = 4
        self.constraintBot.constant = 4
        self.constraintLft.constant = 8
        self.constraintRgt.constant = 8
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.transitionCrossDissolve, .allowAnimatedContent], animations: {
            
            self.lbName.textColor = UIColor.black
            self.lbValuePerFee.textColor = .black
            self.lbValueType.textColor = .black
            self.lbSimble.textColor = .black
            
            self.backGroundView.backgroundColor = UIColor.green
            self.backGroundView.roundedCornerColor(radius: 20)
    
            self.layoutIfNeeded()
        })
    }
}
