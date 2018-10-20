//
//  AddFeeHeaderCell.swift
//  Mulltometro
//
//  Created by George Gomes on 19/10/18.
//  Copyright © 2018 CrowCode. All rights reserved.
//

import UIKit

class AddFeeHeaderCell: UITableViewCell {
    
    @IBOutlet weak var btAdd: UIButton!
    @IBOutlet weak var btCancel: UIButton! {
        didSet {
            btCancel.isHidden = true
        }
    }
    
    var delegate: RegisterRequester!

    @IBOutlet weak var lbFeeType: UILabel!
    
    @IBAction func didTapAdd(_ sender: Any) {
        
        guard let title = btAdd.titleLabel, let text = title.text else { return }
        if text == "+" {
            self.btCancel.isHidden = false
            btAdd.setTitle("Save", for: .normal)
            delegate.addFee()
        } else {
            
        }
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
        btCancel.isHidden = true
        btAdd.setTitle("+", for: .normal)
        delegate.cancelFee()
    }
}

protocol RegisterRequester {
    func addFee()
    func cancelFee()
    func saveFee()
}
