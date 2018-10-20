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
    
    @IBOutlet weak var constraintTfName: NSLayoutConstraint!
    @IBOutlet weak var feeRegisterStackView: UIStackView!
    
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfValuePerFee: UITextField!
    @IBOutlet weak var tfValueType: UITextField!
    @IBOutlet weak var tfSimble: UITextField!
    
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbValuePerFee: UILabel!
    @IBOutlet weak var lbValueType: UILabel!
    @IBOutlet weak var lbSimble: UILabel!
    
    func animationSave(with tableView: UITableView){
        self.constraintTop.constant = 4
        self.constraintBot.constant = 4
        self.constraintLft.constant = 8
        self.constraintRgt.constant = 8
        self.constraintTfName.constant = 0
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.transitionCrossDissolve, .allowAnimatedContent], animations: {
            self.tfValuePerFee.backgroundColor = .blackSystem
            self.tfValueType.backgroundColor = .blackSystem
            self.tfSimble.backgroundColor = .blackSystem
            
            self.backGroundView.backgroundColor = UIColor.redSystem
            self.backGroundView.roundedCornerColor(radius: 20)
            self.layoutIfNeeded()
        })
        
        UIView.transition(with: feeRegisterStackView, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve , animations: {
            self.feeRegisterStackView.spacing = 0 
            self.layoutIfNeeded()
        })
        
        UIView.transition(with: lbName, duration: 0.6, options: UIView.AnimationOptions.transitionCrossDissolve , animations: {
            self.lbName.text = self.tfName.text?.count == 0 ? "New Fee" : self.tfName.text
            self.lbName.textAlignment = .center
            self.layoutIfNeeded()
        }){ (_) in
            tableView.reloadData()
        }
        

        
       
    }
}
